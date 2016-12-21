USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[GetDetail]    Script Date: 21.12.2016 16:42:49 ******/
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
        s.[stravaZadarmo],
        s.[internatZadarmo],
        [idDobrovolnik],
        p.[dtCreated],
        coalesce(p.[amount], 0),
        coalesce(c.[amount], 0),
        coalesce(d.[amount], 0),
        (coalesce(p.[amount], 0) - coalesce(c.[amount], 0) - coalesce(d.[amount], 0))
    from [dbo].[registracia] r
    left join [dbo].[sluziaci] s on s.[id] = r.[idSluziaci]
    left join [dbo].[vw_payment] p on p.[idAccount] = r.[idAccount]
    left join costOfAccount c on c.[idAccount] = r.[idAccount]
    left join [dbo].[vw_donation] d on d.[idAccount] = r.[idAccount]
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
