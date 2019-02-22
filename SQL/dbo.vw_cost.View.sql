USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_cost] (id, idAccount, amount)
AS
    select r.id, r.idAccount,
        -- strava
        (
            1.5 * (cast([nedelaRanajky] as int) + cast([sobotaRanajky] as int)) +
            2.7 * (cast([sobotaObed] as int) + cast([nedelaObed] as int)) +
            2.5 * (cast([piatokVecera] as int) + cast([sobotaVecera] as int)) +
            1.0 * ([piatokVecera2] + [sobotaVecera2])
        ) *
            (1 - coalesce(cast(s.stravaZadarmo as int), 0)) +
        -- tricko
        5.5 * (case when coalesce(idTricko, 0) > 0 then 1 else 0 end) *
            (1 - coalesce(cast(s.trickoZadarmo as int), 0)) +
		-- mikina
        16 * (case when coalesce(idMikina, 0) > 0 then 1 else 0 end) *
            (1 - coalesce(cast(s.mikinaZadarmo as int), 0)) +
        -- internat
        (coalesce(u1.price, 0) + coalesce(u2.price, 0)) *
            (1 - coalesce(cast(s.internatZadarmo as int), 0)) +
        -- registracia
        (case when r.registracnyPoplatok is not null then r.registracnyPoplatok
              when idZbor in (62, 82) then coalesce(fr.amount, 0) * 
                    (1 - coalesce(cast(s.registraciaZadarmo as int), 0))
              else coalesce(fp.amount, 0) *
                    (1 - coalesce(cast(s.registraciaZadarmo as int), 0))
              end)
    from registracia r
    left join ubytovanie u1 on u1.id = r.idUbytovaniePiatokSobota
    left join ubytovanie u2 on u2.id = r.idUbytovanieSobotaNedela
    left join vw_payment p on p.idAccount = r.idAccount
    left join sluziaci s on s.id = r.idSluziaci
    left join poplatok fr on coalesce(fr.dtFrom, r.dtModified) <= r.dtModified and r.dtModified <= fr.dtTo
    left join poplatok fp on coalesce(fp.dtPaymentFrom, p.dtCreated, getdate()) <= coalesce(p.dtCreated, getdate()) and
                             coalesce(p.dtCreated, getdate()) <= fp.dtPaymentTo;
GO
