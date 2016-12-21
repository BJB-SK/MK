USE [konfera]
GO
/****** Object:  Table [dbo].[import_cz]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_cz](
	[date] [datetime] NULL,
	[description] [nvarchar](255) NULL,
	[payer] [nvarchar](255) NULL,
	[ks] [float] NULL,
	[vs] [int] NULL,
	[amount] [float] NULL
) ON [PRIMARY]

GO
