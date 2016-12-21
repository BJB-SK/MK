delete from [dbo].[registracia];
delete from [dbo].[account];
delete from [dbo].[email];
delete from [dbo].[team];

DBCC CHECKIDENT ('dbo.account', RESEED, 1);
DBCC CHECKIDENT ('dbo.email', RESEED, 1);
DBCC CHECKIDENT ('dbo.registracia', RESEED, 1);
DBCC CHECKIDENT ('dbo.team', RESEED, 1);

go
