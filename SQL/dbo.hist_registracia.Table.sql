USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hist_registracia](
	[op] [varchar](1) NULL,
	[dt] [datetime] NULL,
	[id] [int] NOT NULL,
	[idAccount] [int] NOT NULL,
	[meno] [nvarchar](max) NULL,
	[priezvisko] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[telefon] [nvarchar](max) NULL,
	[idZbor] [int] NULL,
	[inyZbor] [nvarchar](max) NULL,
	[piatokVecera] [bit] NOT NULL,
	[piatokVecera2] [int] NOT NULL,
	[idUbytovaniePiatokSobota] [int] NOT NULL,
	[sobotaRanajky] [bit] NOT NULL,
	[sobotaObed] [bit] NOT NULL,
	[sobotaVecera] [bit] NOT NULL,
	[sobotaVecera2] [int] NOT NULL,
	[idUbytovanieSobotaNedela] [int] NOT NULL,
	[nedelaRanajky] [bit] NOT NULL,
	[nedelaObed] [bit] NOT NULL,
	[sach] [bit] NOT NULL,
	[pingPong] [bit] NOT NULL,
	[idTricko] [int] NULL,
	[poznamka] [nvarchar](max) NULL,
	[dtModified] [datetime] NULL,
	[idSluziaci] [int] NULL,
	[idDobrovolnik] [int] NULL,
	[dtPrisli] [datetime] NULL,
	[asiNepridu] [bit] NULL,
	[registracnyPoplatok] [decimal](18, 4) NULL,
	[idMikina] [int] NULL,
	[idFarbaTricka] [int] NULL,
	[idFarbaMikiny] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
