USE [konfera]
GO
/****** Object:  Table [dbo].[import]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import](
	[date] [datetime] NULL,
	[description] [nvarchar](255) NULL,
	[payer] [nvarchar](255) NULL,
	[ks] [float] NULL,
	[vs] [int] NULL,
	[ss] [nvarchar](255) NULL,
	[amount] [float] NULL
) ON [PRIMARY]

GO
