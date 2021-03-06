USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImportToPayment]
AS
    delete from [dbo].[payment]
    where cash = 0 and idCurrency = 1;

    -- EUR
    insert into [dbo].[payment] 
        ([idAccount], [note], [payer], [idCurrency], [amount], [dtCreated], [cash])
    select 
        a.[id], [description], [payer], 1, i.[amount], convert(date, i.[date], 105), 0
    from [dbo].[import] i
    inner join [dbo].[identifier] v on v.[identifier] = i.[vs]
    inner join [dbo].[account] a on a.[idIdentifier] = v.[id];

    delete i
    from [dbo].[import] i
    inner join [dbo].[identifier] v on v.[identifier] = i.[vs]
    inner join [dbo].[account] a on a.[idIdentifier] = v.[id];
    
    -- CZK
    insert into [dbo].[payment] 
        ([idAccount], [note], [payer], [idCurrency], [amount], [dtCreated], [cash])
    select 
        a.[id], [description], [payer], 2, i.[amount], convert(date, i.[date], 105), 0
    from [dbo].[import_cz] i
    inner join [dbo].[identifier] v on v.[identifier] = i.[vs]
    inner join [dbo].[account] a on a.[idIdentifier] = v.[id];

    delete i
    from [dbo].[import_cz] i
    inner join [dbo].[identifier] v on v.[identifier] = i.[vs]
    inner join [dbo].[account] a on a.[idIdentifier] = v.[id];
GO
