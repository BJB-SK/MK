USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_productCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idJob] [int] NOT NULL,
	[idProductCategory] [int] NOT NULL,
 CONSTRAINT [PK_job_productCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[job_productCategory] ON 

INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (1, 2, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (2, 14, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (3, 15, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (4, 16, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (5, 17, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (6, 18, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (7, 19, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (8, 22, 1)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (9, 2, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (10, 14, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (11, 15, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (12, 16, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (13, 17, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (14, 18, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (15, 19, 2)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (16, 1, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (17, 2, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (18, 13, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (19, 14, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (20, 15, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (21, 16, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (22, 17, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (23, 18, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (24, 19, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (25, 22, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (26, 24, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (40, 26, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (41, 27, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (42, 28, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (43, 29, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (44, 30, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (45, 31, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (46, 32, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (47, 33, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (48, 34, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (49, 35, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (50, 36, 3)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (27, 2, 4)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (28, 2, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (29, 13, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (30, 14, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (31, 15, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (32, 16, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (33, 17, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (34, 18, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (35, 19, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (36, 20, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (37, 22, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (38, 23, 6)
INSERT [dbo].[job_productCategory] ([id], [idJob], [idProductCategory]) VALUES (39, 24, 6)
SET IDENTITY_INSERT [dbo].[job_productCategory] OFF
ALTER TABLE [dbo].[job_productCategory] ADD  CONSTRAINT [UQ_job_productCategory] UNIQUE NONCLUSTERED 
(
	[idProductCategory] ASC,
	[idJob] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[job_productCategory]  WITH CHECK ADD  CONSTRAINT [FK_job_productCategory_job] FOREIGN KEY([idJob])
REFERENCES [dbo].[job] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[job_productCategory] CHECK CONSTRAINT [FK_job_productCategory_job]
GO
ALTER TABLE [dbo].[job_productCategory]  WITH CHECK ADD  CONSTRAINT [FK_job_productCategory_productCategory] FOREIGN KEY([idProductCategory])
REFERENCES [dbo].[productCategory] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[job_productCategory] CHECK CONSTRAINT [FK_job_productCategory_productCategory]
GO
