USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUsers]
    @users          [dbo].[ListOfUsers] readonly,
	@products       [dbo].[ListOfProducts] readonly,
    @emails         [dbo].[ListOfEmails] readonly,
    @payerEmail     [nvarchar](max),
    @donation       [decimal](18,4),
    @idCurrency     [int]
AS
BEGIN
    declare @now datetime = getutcdate();
    
    if exists(
        select * 
        from [dbo].[attendee] o
        inner join @users n on lower(ltrim(rtrim(o.[email]))) = lower(ltrim(rtrim(n.[email]))))
    begin
        select cast(0 as int);
        
        select n.[email]
        from [dbo].[attendee] o
        inner join @users n on lower(ltrim(rtrim(o.[email]))) = lower(ltrim(rtrim(n.[email])));
    end
    else
    begin
        select cast(1 as int);

        insert into [dbo].[account] 
            ([email], [dtCreated])
        values 
            (@payerEmail, @now);

        declare @idAccount int = scope_identity();
        declare @idIdentifier int = 1;
        select @idIdentifier = max(coalesce([idIdentifier], 0)) + 1
        from [dbo].[account];
        
        update [dbo].[account] 
        set [idIdentifier] = @idIdentifier
        where [id] = @idAccount;
        
        if coalesce(@donation, 0) > 0 
        begin
            insert into [dbo].[donation] 
                ([idAccount], [amount], [idCurrency], [dtModified])
            values
                (@idAccount, @donation, @idCurrency, @now);
        end

		declare @idMappingTable table(idAttendee int, idFrontend int);

        insert into [dbo].[attendee]
            ([idAccount], [firstName], [lastName], [email], [phoneNumber], [idChurch], [otherChurch], 
			[idJob], [note], [dtModified], [idFrontend])
		output INSERTED.id, INSERTED.idFrontend into @idMappingTable
        select
            @idAccount, [firstName], [lastName], [email], [phoneNumber], [idChurch], [otherChurch], 
			[idJob], [note], @now, [idFrontend]
        from @users;
        
		insert into [dbo].[attendee_product] ([idAttendee], [idProduct], [dtModified])
		select [idAttendee], p.id, @now
		from @products n
		inner join @idMappingTable m on m.idFrontend = n.idFrontend
		inner join dbo.product p on p.code = n.code;
		
        insert into [dbo].[email]
            ([address], [subject], [body], [idIdentifier], [retries], [success])
        select
            [address], [subject], [body], @idIdentifier, 5, 0
        from @emails;
    end
END
GO
