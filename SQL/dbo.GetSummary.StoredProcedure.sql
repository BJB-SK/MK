USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[GetSummary]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSummary]
AS
BEGIN
    declare @piatokVeceraZaplatene int;
    declare @piatokVecera2Zaplatene int;
    declare @sobotaRanajkyZaplatene int;
    declare @sobotaObedZaplatene int;
    declare @sobotaVeceraZaplatene int;
    declare @sobotaVecera2Zaplatene int;
    declare @nedelaRanajkyZaplatene int;
    declare @nedelaObedZaplatene int;
    declare @internatPiatokSobotaZaplatene1 int;
    declare @internatSobotaNedelaZaplatene1 int;
    declare @internatPiatokSobotaZaplatene2 int;
    declare @internatSobotaNedelaZaplatene2 int;
    
    -- zaplatene
    select
        @piatokVeceraZaplatene  = coalesce(sum(cast([piatokVecera] as int)),0 ),
        @piatokVecera2Zaplatene = coalesce(sum([piatokVecera2]), 0),
        @sobotaRanajkyZaplatene = coalesce(sum(cast([sobotaRanajky] as int)), 0),
        @sobotaObedZaplatene    = coalesce(sum(cast([sobotaObed] as int)), 0),
        @sobotaVeceraZaplatene  = coalesce(sum(cast([sobotaVecera] as int)), 0),
        @sobotaVecera2Zaplatene = coalesce(sum([sobotaVecera2]), 0),
        @nedelaRanajkyZaplatene = coalesce(sum(cast([nedelaRanajky] as int)), 0),
        @nedelaObedZaplatene    = coalesce(sum(cast([nedelaObed] as int)), 0)
    from [dbo].[registracia] r
    left join [dbo].[sluziaci] s on s.id = r.idSluziaci
    left join [dbo].[vw_payment] p on p.idAccount = r.idAccount
    where
        coalesce(s.[stravaZadarmo], 0) = 1 or
        p.dtCreated is not null or
        idZbor = 62;    -- srbsko

    select
        @internatPiatokSobotaZaplatene1 = coalesce(sum(case when idUbytovaniePiatokSobota = 2 then 1 else 0 end), 0),
        @internatSobotaNedelaZaplatene1 = coalesce(sum(case when idUbytovanieSobotaNedela = 2 then 1 else 0 end), 0),
        @internatPiatokSobotaZaplatene2 = coalesce(sum(case when idUbytovaniePiatokSobota = 3 then 1 else 0 end), 0),
        @internatSobotaNedelaZaplatene2 = coalesce(sum(case when idUbytovanieSobotaNedela = 3 then 1 else 0 end), 0)
    from [dbo].[registracia] r
    left join [dbo].[sluziaci] s on s.id = r.idSluziaci
    left join [dbo].[vw_payment] p on p.idAccount = r.idAccount
    where
        coalesce(s.[internatZadarmo], 0) = 1 or
        p.dtCreated is not null or
        idZbor = 62;    -- srbsko
        
    -- counts
    select  
        count(*),
        sum(cast([piatokVecera] as int)), @piatokVeceraZaplatene,
        sum([piatokVecera2]), @piatokVecera2Zaplatene,
        sum(case when idUbytovaniePiatokSobota = 1 then 1 else 0 end),
        sum(cast([sobotaRanajky] as int)), @sobotaRanajkyZaplatene,
        sum(cast([sobotaObed] as int)), @sobotaObedZaplatene,
        sum(cast([sobotaVecera] as int)), @sobotaVeceraZaplatene,
        sum([sobotaVecera2]), @sobotaVecera2Zaplatene,
        sum(case when idUbytovanieSobotaNedela = 1 then 1 else 0 end),
        sum(cast([nedelaRanajky] as int)), @nedelaRanajkyZaplatene,
        sum(cast([nedelaObed] as int)), @nedelaObedZaplatene,
        sum(cast([sach] as int)),
        sum(cast([pingPong] as int)),
        sum(case when idUbytovaniePiatokSobota = 2 then 1 else 0 end), @internatPiatokSobotaZaplatene1,
        sum(case when idUbytovanieSobotaNedela = 2 then 1 else 0 end), @internatSobotaNedelaZaplatene1,
        sum(case when idUbytovaniePiatokSobota = 3 then 1 else 0 end), @internatPiatokSobotaZaplatene2,
        sum(case when idUbytovanieSobotaNedela = 3 then 1 else 0 end), @internatSobotaNedelaZaplatene2
    from [dbo].[registracia];
    
    -- t-shirts
    select t.[name], count(*)
    from [dbo].[registracia] r
    inner join [dbo].[tricko] t on t.id = r.idTricko
    group by t.[name];
    
    -- t-shirts paid
    select t.[name], count(*)
    from [dbo].[registracia] r
    inner join [dbo].[tricko] t on t.id = r.idTricko
    left join [dbo].[sluziaci] s on s.id = r.idSluziaci
    left join [dbo].[vw_payment] p on p.idAccount = r.idAccount
    where
        coalesce(s.[trickoZadarmo], 0) = 1 or
        p.dtCreated is not null or
        idZbor = 62     -- srbsko
    group by t.[name];
    
    -- expecting money
    select sum(amount)
    from vw_cost;
    
    -- paid by people
    select sum(amount)
    from vw_payment;
    
    -- sluziaci
    select s.name, count(*)
    from registracia r
    inner join sluziaci s on s.id = r.idSluziaci
    where idSluziaci <> 1
    group by s.name
    order by s.name;
    
    -- dobrovolnici
    select d.name, count(*)
    from registracia r
    left join dobrovolnik d on d.id = r.idDobrovolnik
    where idSluziaci = 1
    group by d.name
    order by d.name;
    
    -- poznamka
    select [meno] + ' ' + [priezvisko], [Poznamka]
    from [dbo].[registracia]
    where [Poznamka] <> ''
    order by dtModified asc;
    
    -- by church
    select coalesce(z.[name], r.[InyZbor]) as church, COUNT(*) as count
    from [dbo].[registracia] r
    left join [dbo].[zbor] z on z.id = r.IdZbor
    group by coalesce(z.[name], r.[InyZbor])
    order by count desc, church asc;
END



GO
