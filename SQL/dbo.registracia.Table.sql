USE [konfera]
GO
/****** Object:  Table [dbo].[registracia]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[registracia](
	[id] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_registracia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[registracia] ADD  CONSTRAINT [DF_ubytovaniePiatokSobota]  DEFAULT ((0)) FOR [idUbytovaniePiatokSobota]
GO
ALTER TABLE [dbo].[registracia] ADD  CONSTRAINT [DF_ubytovanieSobotaNedela]  DEFAULT ((0)) FOR [idUbytovanieSobotaNedela]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[account] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_account]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_dobrovolnik] FOREIGN KEY([idDobrovolnik])
REFERENCES [dbo].[dobrovolnik] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_dobrovolnik]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_sluziaci] FOREIGN KEY([idSluziaci])
REFERENCES [dbo].[sluziaci] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_sluziaci]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_tricko] FOREIGN KEY([idTricko])
REFERENCES [dbo].[tricko] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_tricko]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_ubytovaniePiatokSobota] FOREIGN KEY([idUbytovaniePiatokSobota])
REFERENCES [dbo].[ubytovanie] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_ubytovaniePiatokSobota]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_ubytovanieSobotaNedela] FOREIGN KEY([idUbytovanieSobotaNedela])
REFERENCES [dbo].[ubytovanie] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_ubytovanieSobotaNedela]
GO
ALTER TABLE [dbo].[registracia]  WITH CHECK ADD  CONSTRAINT [FK_registracia_zbor] FOREIGN KEY([idZbor])
REFERENCES [dbo].[zbor] ([id])
GO
ALTER TABLE [dbo].[registracia] CHECK CONSTRAINT [FK_registracia_zbor]
GO
/****** Object:  Trigger [dbo].[registracia_delete]    Script Date: 11.3.2017 21:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   trigger [dbo].[registracia_delete]
on [dbo].[registracia]
for delete
as
    declare @now datetime = getutcdate();
    insert into hist_registracia 
        (op, dt, id, idAccount, meno, priezvisko, email, telefon, idZbor, inyZbor, piatokVecera, piatokVecera2, idUbytovaniePiatokSobota, sobotaRanajky, sobotaObed, sobotaVecera, sobotaVecera2, idUbytovanieSobotaNedela, nedelaRanajky, nedelaObed, sach, pingPong, idTricko, poznamka, dtModified, idSluziaci, idDobrovolnik, dtPrisli, asiNepridu, registracnyPoplatok)
    select 
        'D', @now, id, idAccount, meno, priezvisko, email, telefon, idZbor, inyZbor, piatokVecera, piatokVecera2, idUbytovaniePiatokSobota, sobotaRanajky, sobotaObed, sobotaVecera, sobotaVecera2, idUbytovanieSobotaNedela, nedelaRanajky, nedelaObed, sach, pingPong, idTricko, poznamka, dtModified, idSluziaci, idDobrovolnik, dtPrisli, asiNepridu, registracnyPoplatok
    from deleted;

GO
ALTER TABLE [dbo].[registracia] ENABLE TRIGGER [registracia_delete]
GO
/****** Object:  Trigger [dbo].[registracia_update]    Script Date: 11.3.2017 21:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   trigger [dbo].[registracia_update]
on [dbo].[registracia]
for update
as
    declare @now datetime = getutcdate();
    insert into hist_registracia 
        (op, dt, id, idAccount, meno, priezvisko, email, telefon, idZbor, inyZbor, piatokVecera, piatokVecera2, idUbytovaniePiatokSobota, sobotaRanajky, sobotaObed, sobotaVecera, sobotaVecera2, idUbytovanieSobotaNedela, nedelaRanajky, nedelaObed, sach, pingPong, idTricko, poznamka, dtModified, idSluziaci, idDobrovolnik, dtPrisli, asiNepridu, registracnyPoplatok)
    select 
        'U', @now, id, idAccount, meno, priezvisko, email, telefon, idZbor, inyZbor, piatokVecera, piatokVecera2, idUbytovaniePiatokSobota, sobotaRanajky, sobotaObed, sobotaVecera, sobotaVecera2, idUbytovanieSobotaNedela, nedelaRanajky, nedelaObed, sach, pingPong, idTricko, poznamka, dtModified, idSluziaci, idDobrovolnik, dtPrisli, asiNepridu, registracnyPoplatok
    from deleted
    except
    select 
        'U', @now, id, idAccount, meno, priezvisko, email, telefon, idZbor, inyZbor, piatokVecera, piatokVecera2, idUbytovaniePiatokSobota, sobotaRanajky, sobotaObed, sobotaVecera, sobotaVecera2, idUbytovanieSobotaNedela, nedelaRanajky, nedelaObed, sach, pingPong, idTricko, poznamka, dtModified, idSluziaci, idDobrovolnik, dtPrisli, asiNepridu, registracnyPoplatok
    from inserted;

GO
ALTER TABLE [dbo].[registracia] ENABLE TRIGGER [registracia_update]
GO
