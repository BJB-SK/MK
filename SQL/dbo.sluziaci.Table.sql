USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sluziaci](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[tooltip] [nvarchar](max) NULL,
	[registraciaZadarmo] [bit] NOT NULL,
	[trickoZadarmo] [bit] NOT NULL,
	[stravaZadarmo] [bit] NOT NULL,
	[internatZadarmo] [bit] NOT NULL,
	[maxCount] [int] NULL,
	[public] [bit] NOT NULL,
	[mikinaZadarmo] [bit] NOT NULL,
 CONSTRAINT [PK_sluziaci] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_registraciaZadarmo]  DEFAULT ((0)) FOR [registraciaZadarmo]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_trickoZadarmo]  DEFAULT ((0)) FOR [trickoZadarmo]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_stravaZadarmo]  DEFAULT ((0)) FOR [stravaZadarmo]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_internatZadarmo]  DEFAULT ((0)) FOR [internatZadarmo]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_alwaysShow]  DEFAULT ((0)) FOR [public]
GO
ALTER TABLE [dbo].[sluziaci] ADD  CONSTRAINT [DF_sluziaci_mikinaZadarmo]  DEFAULT ((0)) FOR [mikinaZadarmo]
GO
