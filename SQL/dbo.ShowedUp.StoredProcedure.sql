USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[ShowedUp]    Script Date: 21.12.2016 16:42:49 ******/
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
