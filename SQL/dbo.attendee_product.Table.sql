USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendee_product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [int] NOT NULL,
	[idAttendee] [int] NOT NULL,
	[dtModified] [datetime] NULL,
 CONSTRAINT [PK_person_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attendee_product] ADD  CONSTRAINT [UQ_person_product] UNIQUE NONCLUSTERED 
(
	[idAttendee] ASC,
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attendee_product]  WITH CHECK ADD  CONSTRAINT [FK_person_food_food] FOREIGN KEY([idProduct])
REFERENCES [dbo].[product] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[attendee_product] CHECK CONSTRAINT [FK_person_food_food]
GO
ALTER TABLE [dbo].[attendee_product]  WITH CHECK ADD  CONSTRAINT [FK_person_food_person] FOREIGN KEY([idAttendee])
REFERENCES [dbo].[attendee] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[attendee_product] CHECK CONSTRAINT [FK_person_food_person]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[attendee_product_delete]
on [dbo].[attendee_product]
for delete
as
    declare @now datetime = getutcdate();
    insert into hist_attendee_product
        (op, dt, id, idAttendee, idProduct, dtModified)
    select 
        'D', @now, id, idAttendee, idProduct, dtModified
    from deleted;
GO
ALTER TABLE [dbo].[attendee_product] ENABLE TRIGGER [attendee_product_delete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- change trigger
create trigger [dbo].[attendee_product_update]
on [dbo].[attendee_product]
for update
as
    declare @now datetime = getutcdate();
    insert into hist_attendee_product 
        (op, dt, id, idAttendee, idProduct, dtModified)
    select 
        'U', @now, id, idAttendee, idProduct, dtModified
    from deleted
    except
    select 
        'U', @now, id, idAttendee, idProduct, dtModified
    from inserted;
GO
ALTER TABLE [dbo].[attendee_product] ENABLE TRIGGER [attendee_product_update]
GO
