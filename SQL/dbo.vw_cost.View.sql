USE [konfera]
GO
/****** Object:  View [dbo].[vw_cost]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_cost] (id, idAccount, amount)
AS
    with cte_payment as
    (
        select idAccount, min(dtCreated) as dtPayment
        from payment p
        group by idAccount
    )
    select r.id, r.idAccount,
        -- strava
        (2.2 * cast([piatokVecera] as int) +
         1.0 * [piatokVecera2] +
         1.0 * cast([sobotaRanajky] as int) +
         2.5 * cast([sobotaObed] as int) +
         2.2 * cast([sobotaVecera] as int) +
         1.0 * [sobotaVecera2] +
         1.0 * cast([nedelaRanajky] as int) +
         2.5 * cast([nedelaObed] as int)) *
            (1 - coalesce(cast(s.stravaZadarmo as int), 0)) +
        -- tricko
        4 * (case when coalesce(idTricko, 0) > 0 then 1 else 0 end) *
            (1 - coalesce(cast(s.trickoZadarmo as int), 0)) +
        -- internat
        (coalesce(u1.price, 0) + coalesce(u2.price, 0)) *
            (1 - coalesce(cast(s.internatZadarmo as int), 0)) +
        -- registracia
        (case when idZbor in (62, 82) then coalesce(fr.amount, 0) else coalesce(fp.amount, 0) end) *
            (1 - coalesce(cast(s.registraciaZadarmo as int), 0))
    from registracia r
    left join ubytovanie u1 on u1.id = r.idUbytovaniePiatokSobota
    left join ubytovanie u2 on u2.id = r.idUbytovanieSobotaNedela
    left join cte_payment p on p.idAccount = r.idAccount
    left join sluziaci s on s.id = r.idSluziaci
    left join poplatok fr on coalesce(fr.dtFrom, r.dtModified) <= r.dtModified and r.dtModified <= fr.dtTo
    left join poplatok fp on coalesce(fp.dtFrom, p.[dtPayment], getdate()) <= coalesce(p.[dtPayment], getdate()) and
                             coalesce(p.[dtPayment], getdate()) <= fp.dtTo


GO
