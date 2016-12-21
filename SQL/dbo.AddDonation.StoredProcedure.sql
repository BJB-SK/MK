USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[AddDonation]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDonation]
    @idUser     [int],
    @amount     [decimal](18,4)
AS
BEGIN
    declare @idAccount int;
    select @idAccount = [idAccount] 
    from [dbo].[registracia]
    where [id] = @idUser;

    insert into [dbo].[donation] ([idAccount], [amount], [idCurrency], [dtModified])
    values (@idAccount, @amount, 1, getutcdate());
END


GO
