USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_cz](
	[date] [datetime] NULL,
	[date2] [datetime] NULL,
	[payer] [nvarchar](255) NULL,
	[vs] [int] NULL,
	[amount] [float] NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
