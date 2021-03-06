USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idAccount] [int] NOT NULL,
	[idCurrency] [int] NOT NULL,
	[amount] [decimal](18, 4) NOT NULL,
	[note] [nvarchar](max) NULL,
	[payer] [nvarchar](max) NULL,
	[cash] [bit] NOT NULL,
	[dtCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_payments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK_payments_currency] FOREIGN KEY([idCurrency])
REFERENCES [dbo].[currency] ([id])
GO
ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK_payments_currency]
GO
