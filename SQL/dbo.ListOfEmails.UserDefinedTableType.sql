USE [konfera]
GO
/****** Object:  UserDefinedTableType [dbo].[ListOfEmails]    Script Date: 21.12.2016 16:42:48 ******/
CREATE TYPE [dbo].[ListOfEmails] AS TABLE(
	[id] [int] NULL,
	[address] [nvarchar](max) NULL,
	[subject] [nvarchar](max) NULL,
	[body] [nvarchar](max) NULL,
	[success] [bit] NULL,
	[result] [nvarchar](max) NULL
)
GO
