USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sport](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_sport] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[sport] ON 

INSERT [dbo].[sport] ([id], [name]) VALUES (1, N'Futbal')
INSERT [dbo].[sport] ([id], [name]) VALUES (2, N'Volejbal')
INSERT [dbo].[sport] ([id], [name]) VALUES (3, N'Floorbal')
SET IDENTITY_INSERT [dbo].[sport] OFF
