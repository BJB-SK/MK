DELETE FROM [dbo].[poplatok];
DBCC CHECKIDENT ('dbo.poplatok', RESEED, 1);
SET IDENTITY_INSERT dbo.poplatok ON;
INSERT INTO [dbo].[poplatok] ([id], [dtFrom], [dtTo], [amount], [online], [comment]) 
select 1, null,                  '2016-12-31 23:59:59', 4, 1, '1. vlna'
union all
select 2, '2017-01-01 00:00:00', '2017-01-31 23:59:59', 8, 1, '2. vlna'
union all
select 3, '2017-02-01 00:00:00', '2017-02-15 23:59:59', 12, 1, '3. vlna'
union all
select 4, '2017-02-17 00:00:00', '2017-02-17 23:59:59', 16, 0, 'Celá MK'
union all
select 5, '2017-02-17 00:00:00', '2017-02-17 23:59:59', 6, 0, 'Len piatok večer'
union all
select 6, '2017-02-18 00:00:00', '2017-02-18 15:29:59', 10, 0, 'Celá sobota'
union all
select 7, '2017-02-18 15:30:00', '2017-02-18 23:59:59', 6, 0, 'Len sobota večer'
SET IDENTITY_INSERT dbo.variabilny OFF;
