USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[currency](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[rate] [float] NOT NULL,
	[paymentInfo] [nvarchar](max) NULL,
 CONSTRAINT [PK_currency] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[currency] ON 

INSERT [dbo].[currency] ([id], [name], [rate], [paymentInfo]) VALUES (1, N'EUR', 1, N'Číslo účtu: <b>xxxxxxxxxx</b><br/>Variabilný symbol: <b>100</b><br/>Špecifický symbol: <b>{0}</b>')
INSERT [dbo].[currency] ([id], [name], [rate], [paymentInfo]) VALUES (2, N'CZK', 26, N'Číslo účtu: <b>xxxxxxxxxx</b><br/>Variabilný symbol: <b>911814</b><br/>Špecifický symbol: <b>{0}</b>')
SET IDENTITY_INSERT [dbo].[currency] OFF
