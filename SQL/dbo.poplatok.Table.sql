USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[poplatok](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dtFrom] [datetime] NULL,
	[dtTo] [datetime] NULL,
	[amount] [decimal](18, 4) NOT NULL,
	[online] [bit] NOT NULL,
	[comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_poplatok] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
