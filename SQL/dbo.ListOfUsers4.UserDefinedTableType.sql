USE [konfera]
GO
CREATE TYPE [dbo].[ListOfUsers4] AS TABLE(
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
	[idFarbaTricka] [int] NULL,
	[idMikina] [int] NULL,
	[idFarbaMikiny] [int] NULL,
	[poznamka] [nvarchar](max) NULL,
	[idSluziaci] [int] NULL,
	[idDobrovolnik] [int] NULL
)
GO
