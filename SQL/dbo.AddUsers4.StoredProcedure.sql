USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUsers4]
    @users          [dbo].[ListOfUsers4] readonly,
    @emails         [dbo].[ListOfEmails] readonly,
    @payerEmail     [nvarchar](max),
    @donation       [decimal](18,4),
    @idCurrency     [int]
AS
BEGIN
    declare @now datetime = getutcdate();
    
    if exists(
        select * 
        from [dbo].[registracia] o
        inner join @users n on lower(ltrim(rtrim(o.[Email]))) = lower(ltrim(rtrim(n.[Email]))))
    begin
        select cast(0 as int);
        
        select n.[Email]
        from [dbo].[registracia] o
        inner join @users n on lower(ltrim(rtrim(o.[Email]))) = lower(ltrim(rtrim(n.[Email])));
    end
    else
    begin
        select cast(1 as int);

        insert into [dbo].[account] 
            ([email], [dtCreated])
        values 
            (@payerEmail, @now);

        declare @idAccount int = scope_identity();
        declare @idVariabilny int = 1;
        select @idVariabilny = max(coalesce([idVariabilny], 0)) + 1
        from [dbo].[account];
        
        update [dbo].[account] 
        set [idVariabilny] = @idVariabilny
        where [id] = @idAccount;
        
        if coalesce(@donation, 0) > 0 
        begin
            insert into [dbo].[donation] 
                ([idAccount], [amount], [idCurrency], [dtModified])
            values
                (@idAccount, @donation, @idCurrency, @now);
        end

        insert into [dbo].[registracia]
            ([idAccount], [meno], [priezvisko], [email], [telefon], [idZbor], [inyZbor], 
            [piatokVecera], [piatokVecera2], [idUbytovaniePiatokSobota],
            [sobotaRanajky], [sobotaObed], [sobotaVecera], [sobotaVecera2], [idUbytovanieSobotaNedela],
            [nedelaRanajky], [nedelaObed], 
            [sach], [pingPong], [idTricko], [idFarbaTricka], [idMikina], [idFarbaMikiny],
			[idSluziaci], [idDobrovolnik], [poznamka], [dtModified])
        select
            @idAccount, [meno], [priezvisko], [email], [telefon], [idZbor], [inyZbor], 
            [piatokVecera], [piatokVecera2], [idUbytovaniePiatokSobota],
            [sobotaRanajky], [sobotaObed], [sobotaVecera], [sobotaVecera2], [idUbytovanieSobotaNedela],
            [nedelaRanajky], [nedelaObed], 
            [sach], [pingPong], [idTricko], [idFarbaTricka], [idMikina], [idFarbaMikiny],
			[idSluziaci], [idDobrovolnik], [poznamka], @now
        from @users;
        
        insert into [dbo].[email]
            ([address], [subject], [body], [idVariabilny], [retries], [success])
        select
            [address], [subject], [body], @idVariabilny, 5, 0
        from @emails;
    end
END

GO
