USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetList]
    @name           [nvarchar](max),
    @idChurch       [int],
    @from           [nvarchar](max),
    @to             [nvarchar](max),
    @arrived        [bit],
    @notArrived     [bit]
AS
BEGIN
    with costOfAccount as
    (
        select idAccount, sum(amount) as amount
        from vw_cost
        group by idAccount
    )
    select 
        r.[id],
        r.[idAccount],
        [meno],
        [priezvisko],
        coalesce(z.[name], r.[inyZbor]),
        t.[name],
        cast((coalesce(p.[amount], 0) - coalesce(c.[amount], 0) - coalesce(d.[amount], 0)) as decimal(18,4)) as diff,
        [dtPrisli]
    from [dbo].[registracia] r
    left join [dbo].[zbor] z on z.[id] = r.[idZbor]
    left join [dbo].[tricko] t on t.[id] = r.[idTricko]
    left join [dbo].[vw_payment] p on p.[idAccount] = r.[idAccount]
    left join costOfAccount c on c.[idAccount] = r.[idAccount]
    left join [dbo].[vw_donation] d on d.[idAccount] = r.[idAccount]
    where
        (@name is null or @name = '' or [meno] + ' ' + [priezvisko] like '%' + @name + '%' or [email] like '%' + @name + '%') and
        (@idChurch is null or @idChurch = 0 or [idZbor] = @idChurch) and
        (@from is null or @from = '' or @from <= left([priezvisko], 1)) and
        (@to is null or @to = '' or left([priezvisko], 1) <= @to) and
        ((@arrived = 1 and [dtPrisli] is not null) or
         (@notArrived = 1 and [dtPrisli] is null))
    order by [priezvisko] asc, [meno] asc;
END

GO
