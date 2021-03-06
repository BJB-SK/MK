USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dtFrom] [datetime] NULL,
	[dtTo] [datetime] NULL,
	[online] [bit] NOT NULL,
	[comment] [nvarchar](max) NULL,
	[dtPaymentFrom] [datetime] NULL,
	[dtPaymentTo] [datetime] NULL,
	[idProduct] [int] NULL,
 CONSTRAINT [PK_poplatok] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[fee] ON 

INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (1, NULL, CAST(N'2019-12-25T23:59:59.000' AS DateTime), 1, N'1. vlna', NULL, CAST(N'2019-12-31T23:59:59.000' AS DateTime), 117)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (2, CAST(N'2019-12-26T00:00:00.000' AS DateTime), CAST(N'2020-01-20T23:59:59.000' AS DateTime), 1, N'2. vlna', CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(N'2020-01-22T23:59:59.000' AS DateTime), 118)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (3, CAST(N'2020-01-21T00:00:00.000' AS DateTime), CAST(N'2020-02-14T23:59:59.000' AS DateTime), 1, N'3. vlna', CAST(N'2020-01-23T00:00:00.000' AS DateTime), CAST(N'2020-02-21T23:59:59.000' AS DateTime), 119)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (4, CAST(N'2020-02-22T00:00:00.000' AS DateTime), CAST(N'2020-02-22T23:59:59.000' AS DateTime), 0, N'Celá MK', CAST(N'2020-02-22T00:00:00.000' AS DateTime), CAST(N'2020-02-22T23:59:59.000' AS DateTime), 120)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (9, CAST(N'2020-02-23T00:00:00.000' AS DateTime), CAST(N'2020-02-23T00:00:00.000' AS DateTime), 0, N'Sobota', CAST(N'2020-02-23T00:00:00.000' AS DateTime), CAST(N'2020-02-23T00:00:00.000' AS DateTime), 121)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (10, NULL, NULL, 0, N'Nedeľa', NULL, NULL, 122)
INSERT [dbo].[fee] ([id], [dtFrom], [dtTo], [online], [comment], [dtPaymentFrom], [dtPaymentTo], [idProduct]) VALUES (11, NULL, NULL, 0, N'Piatok', NULL, NULL, 123)
SET IDENTITY_INSERT [dbo].[fee] OFF
ALTER TABLE [dbo].[fee]  WITH CHECK ADD  CONSTRAINT [FK_fee_product] FOREIGN KEY([idProduct])
REFERENCES [dbo].[product] ([id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[fee] CHECK CONSTRAINT [FK_fee_product]
GO
