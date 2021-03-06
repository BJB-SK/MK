USE [konfera]
GO
CREATE TYPE [dbo].[ListOfUsers] AS TABLE(
	[idFrontend] [int] NULL,
	[firstName] [nvarchar](max) NULL,
	[lastName] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[phoneNumber] [nvarchar](max) NULL,
	[idChurch] [int] NULL,
	[otherChurch] [nvarchar](max) NULL,
	[note] [nvarchar](max) NULL,
	[idJob] [int] NULL
)
GO
