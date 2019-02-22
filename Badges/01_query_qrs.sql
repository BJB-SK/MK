-- save results as 02_qr.pl (delete final comma, add [ ] around the list)
select 
	'{ ' +
	'id => ' + cast([id] as nvarchar(max)) + ', ' +
	'qr => ''' + [seminare] + '''' +
	'},'
from [dbo].[qr]
where [id] <= 800;
