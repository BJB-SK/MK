USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDetail]
    @idUser [int]
AS
BEGIN
    with costOfAccount as
    (
        select idAccount, sum(amount) as amount
        from vw_cost
        group by idAccount
    )
    select
        r.[id], [meno], [priezvisko], [email], [telefon], 
        [idZbor], r.[InyZbor],
        [piatokVecera], [piatokVecera2], [idUbytovaniePiatokSobota],
        [sobotaRanajky], [sobotaObed], [sobotaVecera], [sobotaVecera2], [idUbytovanieSobotaNedela],
        [nedelaRanajky], [nedelaObed], 
        [sach], [pingPong], [idTricko],
        [poznamka], r.[dtModified], [dtPrisli],
        [idSluziaci],
        s.[registraciaZadarmo],
        s.[trickoZadarmo],
        s.[mikinaZadarmo],
        s.[stravaZadarmo],
        s.[internatZadarmo],
        [idDobrovolnik],
        p.[dtCreated],
        cast(coalesce(p.[amount], 0) as decimal(18,4)),
        cast(coalesce(c.[amount], 0) as decimal(18,4)),
        cast(coalesce(d.[amount], 0) as decimal(18,4)),
        cast((coalesce(p.[amount], 0) - coalesce(c.[amount], 0) - coalesce(d.[amount], 0)) as decimal(18,4)),
        cast(case when idZbor in (62, 82) then coalesce(fr.amount, 0) 
             else coalesce(fp.amount, 0) end as decimal(18,4)),
        registracnyPoplatok
    from [dbo].[registracia] r
    left join [dbo].[sluziaci] s on s.[id] = r.[idSluziaci]
    left join [dbo].[vw_payment] p on p.[idAccount] = r.[idAccount]
    left join costOfAccount c on c.[idAccount] = r.[idAccount]
    left join [dbo].[vw_donation] d on d.[idAccount] = r.[idAccount]
    left join poplatok fr on coalesce(fr.dtFrom, r.dtModified) <= r.dtModified and r.dtModified <= fr.dtTo
    left join poplatok fp on coalesce(fp.dtFrom, p.[dtCreated], getdate()) <= coalesce(p.[dtCreated], getdate()) and
                             coalesce(p.[dtCreated], getdate()) <= fp.dtTo
    where r.[id] = @idUser;
    
    declare @idAccount int;
    select @idAccount = [idAccount] 
    from [dbo].[registracia]
    where [id] = @idUser;
    
    select [id], [meno] + ' ' + [priezvisko]
    from [dbo].[registracia]
    where [id] <> @idUser and [idAccount] = @idAccount
    order by 2 asc;
END

GO
