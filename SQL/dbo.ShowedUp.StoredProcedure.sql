USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShowedUp]
    @idAttendee [int]
AS
    update [dbo].[attendee] set 
        [dtShowedUp] = getutcdate()
    where [id] = @idAttendee;
GO
