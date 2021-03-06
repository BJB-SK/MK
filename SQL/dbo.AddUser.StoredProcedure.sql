USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser]
    @firstName	    [nvarchar](max),
    @lastName	    [nvarchar](max),
    @email		    [nvarchar](max),
    @phoneNumber    [nvarchar](max),
    @idChurch	    [int] = null,
    @otherChurch    [nvarchar](max),
    @idJob		    [int] = null,
    @note		    [nvarchar](max),
	@donation	    [decimal](18,4) = null,
    @extraFee	    [decimal](18,4) = null,
	@products	    dbo.[ListOfInts] readonly,
    @newId          [int] output
AS
BEGIN
    declare @now datetime = getutcdate();

    insert into [dbo].[account] 
        ([email], [dtCreated])
    values 
        (@email, @now);

    declare @idAccount int = scope_identity();
    
    if coalesce(@donation, 0) > 0 
    begin
        insert into [dbo].[donation] 
            ([idAccount], [amount], [idCurrency], [dtModified])
        values
            (@idAccount, @donation, 1, @now);
    end

    insert into [dbo].[attendee] (
		[idAccount], 
		[firstName],
		[lastName],
		[email],
		[phoneNumber],
		[idChurch],
		[otherChurch], 
        [note],
		[idJob],
		[extraFee],
		[dtModified]
	) values (
		@idAccount,
		@firstName,
		@lastName,
		@email,
		@phoneNumber,
		@idChurch,
		@otherChurch, 
		@note,
		@idJob,
		@extraFee,
		@now
	);
        
    set @newId = scope_identity();
    
	insert into dbo.attendee_product (idAttendee, idProduct, dtModified) 
	select @newId, p.value, @now
	from @products p;
END
GO
