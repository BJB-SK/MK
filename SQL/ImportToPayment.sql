SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ImportToPayment]
AS
    -- EUR
    update [dbo].[import] set vs = 186112094 where vs = 18611209; -- zuzana stevove

    insert into [dbo].[payment] 
        ([idAccount], [note], [payer], [idCurrency], [amount], [dtCreated], [cash])
    select 
        a.[id], [description], [payer], 1, i.[amount], convert(date, i.[date], 105), 0
    from [dbo].[import] i
    inner join [dbo].[variabilny] v on v.[vs] = i.[vs]
    inner join [dbo].[account] a on a.[idVariabilny] = v.[id];

    delete i
    from [dbo].[import] i
    inner join [dbo].[variabilny] v on v.[vs] = i.[vs]
    inner join [dbo].[account] a on a.[idVariabilny] = v.[id];
    
    -- CZK
    insert into [dbo].[payment] 
        ([idAccount], [note], [payer], [idCurrency], [amount], [dtCreated], [cash])
    select 
        a.[id], [description], [payer], 2, i.[amount], convert(date, i.[date], 105), 0
    from [dbo].[import_cz] i
    inner join [dbo].[variabilny] v on v.[vs] = i.[vs]
    inner join [dbo].[account] a on a.[idVariabilny] = v.[id];

    delete i
    from [dbo].[import_cz] i
    inner join [dbo].[variabilny] v on v.[vs] = i.[vs]
    inner join [dbo].[account] a on a.[idVariabilny] = v.[id];
