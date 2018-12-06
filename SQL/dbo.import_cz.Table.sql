USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_cz](
	[date] [nvarchar](255) NULL,
	[amount] [float] NULL,
	[currentcy] [nvarchar](255) NULL,
	[balance] [float] NULL,
	[ks] [nvarchar](255) NULL,
	[ss] [nvarchar](255) NULL,
	[vs] [int] NULL,
	[operation] [nvarchar](255) NULL,
	[payer] [nvarchar](255) NULL,
	[account] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
