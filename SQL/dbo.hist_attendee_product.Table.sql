USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hist_attendee_product](
	[op] [varchar](1) NULL,
	[dt] [datetime] NULL,
	[id] [int] NOT NULL,
	[idAttendee] [int] NOT NULL,
	[idProduct] [int] NULL,
	[dtModified] [datetime] NULL
) ON [PRIMARY]
GO
