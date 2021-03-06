USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @idAttendee	    [int] = null,
    @firstName	    [nvarchar](max),
    @lastName	    [nvarchar](max),
    @email		    [nvarchar](max),
    @phoneNumber    [nvarchar](max),
    @idChurch	    [int] = null,
    @otherChurch    [nvarchar](max),
    @idJob		    [int] = null,
    @note		    [nvarchar](max),
    @extraFee	    [decimal](18,4) = null,
	@products	    dbo.[ListOfInts] readonly
AS
BEGIN
    update [dbo].[attendee] set 
        [firstName] = @firstName,
        [lastName] = @lastName,
        [email] = @email,
        [phoneNumber] = @phoneNumber,
        [idChurch] = @idChurch,
        [otherChurch] = @otherChurch,
        [note] = @note,
        [idJob] = @idJob,
        [extraFee] = @extraFee
    where id = @idAttendee;

	-- removed products
	delete ap
	from dbo.attendee_product ap
	left join @products n on n.value = ap.idProduct
	where 
		idAttendee = @idAttendee and
		n.value is null;

	-- newly added products
	insert into dbo.attendee_product (idAttendee, idProduct, dtModified) 
	select @idAttendee, n.value, GETUTCDATE()
	from @products n
	left join dbo.attendee_product ap on ap.idProduct = n.value and idAttendee = @idAttendee
	where ap.id is null;
END
GO
