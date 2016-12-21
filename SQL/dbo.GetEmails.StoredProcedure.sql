USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[GetEmails]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmails]
AS
BEGIN
    select e.[id], e.[address], e.[subject], e.[body], v.[vs]
    from [dbo].[email] e
    left join [dbo].[variabilny] v on v.[id] = e.[idVariabilny]
    where 
        e.[success] = 0 and 
        e.[retries] > 0;
END


GO
