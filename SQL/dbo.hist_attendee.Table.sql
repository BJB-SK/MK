USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hist_attendee](
	[op] [varchar](1) NULL,
	[dt] [datetime] NULL,
	[id] [int] NOT NULL,
	[idAccount] [int] NOT NULL,
	[firstName] [nvarchar](max) NULL,
	[lastName] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[phoneNumber] [nvarchar](max) NULL,
	[idChurch] [int] NULL,
	[otherChurch] [nvarchar](max) NULL,
	[note] [nvarchar](max) NULL,
	[dtModified] [datetime] NULL,
	[idJob] [int] NULL,
	[dtShowedUp] [datetime] NULL,
	[extraFee] [decimal](18, 4) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
