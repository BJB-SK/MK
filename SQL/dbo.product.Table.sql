USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[price] [decimal](18, 4) NULL,
	[max] [int] NULL,
	[code] [nvarchar](15) NOT NULL,
	[idProductCategory] [int] NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (1, N'Piatok večera', CAST(2.5000 AS Decimal(18, 4)), 170, N'pv', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (2, N'Piatok 2. večera (bageta)', CAST(1.0000 AS Decimal(18, 4)), 150, N'pv2', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (3, N'Sobota raňajky', CAST(1.5000 AS Decimal(18, 4)), 220, N'sr', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (4, N'Sobota obed', CAST(2.7000 AS Decimal(18, 4)), 260, N'so', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (5, N'Sobota večera', CAST(2.5000 AS Decimal(18, 4)), 230, N'sv', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (6, N'Sobota 2. večera (bageta)', CAST(1.0000 AS Decimal(18, 4)), 150, N'sv2', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (7, N'Nedeľa raňajky', CAST(1.5000 AS Decimal(18, 4)), 220, N'nr', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (8, N'Nedeľa obed', CAST(2.7000 AS Decimal(18, 4)), 225, N'no', 1)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (105, N'Piatok - sobota trieda', CAST(1.0000 AS Decimal(18, 4)), NULL, N'pst', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (107, N'Piatok - sobota tichá trieda', CAST(1.0000 AS Decimal(18, 4)), NULL, N'pstt', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (109, N'Piatok - sobota internát 1-posteľová izba', CAST(12.0000 AS Decimal(18, 4)), 20, N'psint1', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (110, N'Piatok - sobota internát 2-posteľová izba', CAST(12.0000 AS Decimal(18, 4)), 20, N'psint2', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (111, N'Sobota - nedeľa trieda', CAST(1.0000 AS Decimal(18, 4)), NULL, N'snt', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (112, N'Sobota - nedeľa tichá trieda', CAST(1.0000 AS Decimal(18, 4)), NULL, N'sntt', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (113, N'Sobota - nedeľa internát 1-posteľová izba', CAST(12.0000 AS Decimal(18, 4)), 20, N'snint1', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (114, N'Sobota - nedeľa internát 2-posteľová izba', CAST(12.0000 AS Decimal(18, 4)), 20, N'snint2', 2)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (115, N'Šach', CAST(0.0000 AS Decimal(18, 4)), 20, N'chess', 5)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (116, N'Ping-pong', CAST(0.0000 AS Decimal(18, 4)), 20, N'pingPong', 5)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (117, N'Registrácia - 1. vlna', CAST(6.0000 AS Decimal(18, 4)), NULL, N'reg1', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (118, N'Registrácia - 2. vlna', CAST(9.0000 AS Decimal(18, 4)), NULL, N'reg2', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (119, N'Registrácia - 3. vlna', CAST(12.0000 AS Decimal(18, 4)), NULL, N'reg3', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (120, N'Registrácia - celá MK', CAST(15.0000 AS Decimal(18, 4)), NULL, N'reg', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (121, N'Registrácia - len sobota', CAST(10.0000 AS Decimal(18, 4)), NULL, N'regs', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (122, N'Registrácia - len nedeľa', CAST(3.0000 AS Decimal(18, 4)), NULL, N'regn', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (123, N'Registrácia - len piatok', CAST(5.0000 AS Decimal(18, 4)), NULL, N'regp', 6)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (124, N'Tričko Dámske S Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da s zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (125, N'Tričko Dámske S Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da s ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (126, N'Tričko Dámske M Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da m zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (127, N'Tričko Dámske M Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da m ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (128, N'Tričko Dámske L Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da l zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (129, N'Tričko Dámske L Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da l ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (130, N'Tričko Dámske XL Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da xl zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (131, N'Tričko Dámske XL Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da xl ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (132, N'Tričko Dámske XXL Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da xxl zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (133, N'Tričko Dámske XXL Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr da xxl ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (134, N'Tričko Pánske S Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa s zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (135, N'Tričko Pánske S Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa s ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (136, N'Tričko Pánske M Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa m zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (137, N'Tričko Pánske M Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa m ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (138, N'Tričko Pánske L Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa l zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (139, N'Tričko Pánske L Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa l ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (140, N'Tričko Pánske XL Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa xl zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (141, N'Tričko Pánske XL Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa xl ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (142, N'Tričko Pánske XXL Žlté', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa xxl zl', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (143, N'Tričko Pánske XXL Ružové', CAST(5.5000 AS Decimal(18, 4)), 100, N'tr pa xxl ru', 3)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (144, N'Mikina Dámska S Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da s ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (145, N'Mikina Dámska S Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da s zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (146, N'Mikina Dámska M Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da m ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (147, N'Mikina Dámska M Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da m zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (148, N'Mikina Dámska L Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da l ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (149, N'Mikina Dámska L Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da l zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (150, N'Mikina Dámska XL Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da xl ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (151, N'Mikina Dámska XL Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da xl zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (152, N'Mikina Dámska XXL Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da xxl ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (153, N'Mikina Dámska XXL Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi da xxl zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (154, N'Mikina Pánska S Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa s ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (155, N'Mikina Pánska S Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa s zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (156, N'Mikina Pánska M Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa m ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (157, N'Mikina Pánska M Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa m zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (158, N'Mikina Pánska L Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa l ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (159, N'Mikina Pánska L Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa l zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (160, N'Mikina Pánska XL Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa xl ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (161, N'Mikina Pánska XL Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa xl zl', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (162, N'Mikina Pánska XXL Čierna', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa xxl ci', 4)
INSERT [dbo].[product] ([id], [name], [price], [max], [code], [idProductCategory]) VALUES (163, N'Mikina Pánska XXL Žltá', CAST(16.0000 AS Decimal(18, 4)), 100, N'mi pa xxl zl', 4)
SET IDENTITY_INSERT [dbo].[product] OFF
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_productCategory] FOREIGN KEY([idProductCategory])
REFERENCES [dbo].[productCategory] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_productCategory]
GO
