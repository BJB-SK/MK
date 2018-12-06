USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import](
	[date] [datetime] NULL,
	[date2] [datetime] NULL,
	[account] [nvarchar](255) NULL,
	[bank] [nvarchar](255) NULL,
	[payer] [nvarchar](255) NULL,
	[amount] [float] NULL,
	[currency] [nvarchar](255) NULL,
	[reference] [nvarchar](255) NULL,
	[ss] [nvarchar](255) NULL,
	[vs] [bigint] NULL,
	[ks] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[payer_id] [nvarchar](255) NULL,
	[batch_id] [nvarchar](255) NULL,
	[balance] [float] NULL,
	[F16] [nvarchar](255) NULL
) ON [PRIMARY]
GO
