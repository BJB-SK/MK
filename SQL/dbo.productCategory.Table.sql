USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
 CONSTRAINT [PK_productCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[productCategory] ON 

INSERT [dbo].[productCategory] ([id], [name]) VALUES (1, N'Strava')
INSERT [dbo].[productCategory] ([id], [name]) VALUES (2, N'Ubytovanie')
INSERT [dbo].[productCategory] ([id], [name]) VALUES (3, N'Tričko')
INSERT [dbo].[productCategory] ([id], [name]) VALUES (4, N'Mikina')
INSERT [dbo].[productCategory] ([id], [name]) VALUES (5, N'Šport')
INSERT [dbo].[productCategory] ([id], [name]) VALUES (6, N'Registračný poplatok')
SET IDENTITY_INSERT [dbo].[productCategory] OFF
