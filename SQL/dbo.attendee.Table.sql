USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendee](
	[id] [int] IDENTITY(1,1) NOT NULL,
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
	[extraFee] [decimal](18, 4) NULL,
	[idFrontend] [int] NULL,
 CONSTRAINT [PK_attendee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[attendee]  WITH CHECK ADD  CONSTRAINT [FK_attendee_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[account] ([id])
GO
ALTER TABLE [dbo].[attendee] CHECK CONSTRAINT [FK_attendee_account]
GO
ALTER TABLE [dbo].[attendee]  WITH CHECK ADD  CONSTRAINT [FK_attendee_church] FOREIGN KEY([idChurch])
REFERENCES [dbo].[church] ([id])
GO
ALTER TABLE [dbo].[attendee] CHECK CONSTRAINT [FK_attendee_church]
GO
ALTER TABLE [dbo].[attendee]  WITH CHECK ADD  CONSTRAINT [FK_attendee_job] FOREIGN KEY([idJob])
REFERENCES [dbo].[job] ([id])
GO
ALTER TABLE [dbo].[attendee] CHECK CONSTRAINT [FK_attendee_job]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[attendee_delete]
on [dbo].[attendee]
for delete
as
    declare @now datetime = getutcdate();
    insert into hist_attendee 
        (op, dt, id, idAccount, firstName, lastName, email, phoneNumber, idChurch, otherChurch, note, dtModified, idJob, dtShowedUp, extraFee)
    select 
        'D', @now, id, idAccount, firstName, lastName, email, phoneNumber, idChurch, otherChurch, note, dtModified, idJob, dtShowedUp, extraFee
    from deleted;
GO
ALTER TABLE [dbo].[attendee] ENABLE TRIGGER [attendee_delete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- change trigger
CREATE trigger [dbo].[attendee_update]
on [dbo].[attendee]
for update
as
    declare @now datetime = getutcdate();
    insert into hist_attendee 
        (op, dt, id, idAccount, firstName, lastName, email, phoneNumber, idChurch, otherChurch, note, dtModified, idJob, dtShowedUp, extraFee)
    select 
        'U', @now, id, idAccount, firstName, lastName, email, phoneNumber, idChurch, otherChurch, note, dtModified, idJob, dtShowedUp, extraFee
    from deleted
    except
    select 
        'U', @now, id, idAccount, firstName, lastName, email, phoneNumber, idChurch, otherChurch, note, dtModified, idJob, dtShowedUp, extraFee
    from inserted;
GO
ALTER TABLE [dbo].[attendee] ENABLE TRIGGER [attendee_update]
GO
