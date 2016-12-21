DELETE FROM [dbo].[ubytovanie];
DBCC CHECKIDENT ('dbo.ubytovanie', RESEED, 1);
SET IDENTITY_INSERT dbo.ubytovanie ON;
INSERT INTO [dbo].[ubytovanie] ([id], [name], [price])
select 0, 'Trieda', 0
union all
select 1, 'Tichá trieda', 0
union all
select 2, 'Internát jednoposteľový', 10
union all
select 3, 'Internát dvojposteľový', 7
SET IDENTITY_INSERT dbo.variabilny OFF;
