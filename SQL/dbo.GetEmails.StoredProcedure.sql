USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmails]
AS
BEGIN
    select e.[id], e.[address], e.[subject], e.[body], i.[identifier]
    from [dbo].[email] e
    left join [dbo].[identifier] i on i.[id] = e.[idIdentifier]
    where 
        e.[success] = 0 and 
        e.[retries] > 0;
END
GO
