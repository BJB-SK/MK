USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShowedUp]
    @id [int]
AS
    update [dbo].[registracia] set 
        [dtPrisli] = getutcdate()
    where [id] = @id;

GO
