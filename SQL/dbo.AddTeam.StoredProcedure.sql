USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTeam]
    @idSport    [int],
    @name       [nvarchar](max),
    @player1    [nvarchar](max),
    @player2    [nvarchar](max),
    @player3    [nvarchar](max),
    @player4    [nvarchar](max),
    @player5    [nvarchar](max),
    @player6    [nvarchar](max),
    @player7    [nvarchar](max)
AS
BEGIN
    declare @now datetime = getutcdate();
    
    insert into [dbo].[team]
        ([idSport], [name], [player1], [player2], [player3], [player4], [player5], [player6], [player7], [dtModified])
    values
        (@idSport, @name, @player1, @player2, @player3, @player4, @player5, @player6, @player7, @now);
END
GO
