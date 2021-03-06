USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[donation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idAccount] [int] NULL,
	[amount] [decimal](18, 4) NOT NULL,
	[idCurrency] [int] NOT NULL,
	[dtModified] [datetime] NULL,
 CONSTRAINT [PK_donation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[donation]  WITH CHECK ADD  CONSTRAINT [FK_donation_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[account] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[donation] CHECK CONSTRAINT [FK_donation_account]
GO
ALTER TABLE [dbo].[donation]  WITH CHECK ADD  CONSTRAINT [FK_donation_currency] FOREIGN KEY([idCurrency])
REFERENCES [dbo].[currency] ([id])
GO
ALTER TABLE [dbo].[donation] CHECK CONSTRAINT [FK_donation_currency]
GO
