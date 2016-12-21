USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[AddPayment]    Script Date: 21.12.2016 16:42:49 ******/
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
    from [dbo].[registracia]
    where [id] = @idUser;
    
    insert into [dbo].[payment] 
        ([idAccount], [idCurrency], [amount], [note], [payer], [cash], [dtCreated])
    select 
        @idAccount, 1, @amount, @note, [meno] + ' ' + [priezvisko], 1, getutcdate()
    from [dbo].[registracia]
    where [id] = @idUser;
END


GO
