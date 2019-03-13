delete from [dbo].[attendee];
delete from [dbo].[attendee_product];
delete from [dbo].[account];
delete from [dbo].[email];
delete from [dbo].[team];
delete from [dbo].[identifier];
delete from [dbo].[payment];
delete from [dbo].[qr];

DBCC CHECKIDENT ('dbo.account', RESEED, 1);
DBCC CHECKIDENT ('dbo.email', RESEED, 1);
DBCC CHECKIDENT ('dbo.attendee', RESEED, 1);
DBCC CHECKIDENT ('dbo.attendee_product', RESEED, 1);
DBCC CHECKIDENT ('dbo.team', RESEED, 1);
DBCC CHECKIDENT ('dbo.identifier', RESEED, 1);
DBCC CHECKIDENT ('dbo.payment', RESEED, 1);
DBCC CHECKIDENT ('dbo.qr', RESEED, 1);

delete from [dbo].[hist_attendee];
delete from [dbo].[hist_attendee_product];
delete from [dbo].[donation];
delete from [dbo].[import];

go
