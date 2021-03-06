USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPayment]
    @idUser     [int],
    @amount     [decimal](18,4),
    @note       [nvarchar](max)
AS
BEGIN
    declare @idAccount int;
    select @idAccount = [idAccount] 
    from [dbo].[attendee]
    where [id] = @idUser;
    
    insert into [dbo].[payment] 
        ([idAccount], [idCurrency], [amount], [note], [payer], [cash], [dtCreated])
    select 
        @idAccount, 1, @amount, @note, [firstName] + ' ' + [lastName], 1, getutcdate()
    from [dbo].[attendee]
    where [id] = @idUser;
END
GO
