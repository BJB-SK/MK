USE [konfera]
GO
CREATE TYPE [dbo].[ListOfProducts] AS TABLE(
	[idFrontend] [int] NULL,
	[code] [nvarchar](max) NULL
)
GO
