USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[tooltip] [nvarchar](max) NULL,
	[maxCount] [int] NULL,
	[public] [bit] NOT NULL,
 CONSTRAINT [PK_sluziaci] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[job] ON 

INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (1, N'Dobrovoľník', N'Som ochotná/ý slúžiť a byť k dispozícii pre rôzne úlohy počas celého času trvania konferencie', 100, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (2, N'Projekcia + kamery', N'Budem veci filmovat', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (13, N'Vedúci tímu dobrovoľníkov', N'Má na starosti tím dobrovolníkov', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (14, N'Zvukársky tím', N'Zvuk', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (15, N'TOM', N'TOM', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (16, N'Médiá', NULL, NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (17, N'Osvetľovači', NULL, NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (18, N'Rečník', N'Seminár alebo hlavná téma', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (19, N'Koordinátor', NULL, NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (20, N'Prezentácia vo vestibule', N'Prezentacia sluzieb/predaj knih', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (22, N'Duchovný poradca', NULL, NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (23, N'reg poplatok zadarmo', N'registracny zadarmo po dohode s TOM', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (24, N'Fotograf', N'Foto', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (25, N'Platba na mieste', N'platba na mieste', NULL, 0)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (26, N'Pukancovo - stoličkový', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (27, N'SBS a nosiči aparatúry', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (28, N'WC', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (29, N'Modlitebná miestnosť, označenie tried', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (30, N'Občerstvenie', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (31, N'Poriadkový tím - hlavná sala', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (32, N'Poriadkový tím - odpad + jedáleň', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (33, N'Info + registrácia', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (34, N'Kaviareň', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (35, N'DEPO + športy', NULL, 10, 1)
INSERT [dbo].[job] ([id], [name], [tooltip], [maxCount], [public]) VALUES (36, N'Fotograf', NULL, 10, 1)
SET IDENTITY_INSERT [dbo].[job] OFF
ALTER TABLE [dbo].[job] ADD  CONSTRAINT [DF_sluziaci_alwaysShow]  DEFAULT ((0)) FOR [public]
GO
