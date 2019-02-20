-- save results as 02_export.pl (delete final comma, add [ ] around the list)
select 
	'{ ' +
	'id => ' + cast(r.[Id] as nvarchar(max)) + ', ' +
	'name => ''' + [Meno] + ' ' + [Priezvisko] + ''', ' +
	'church => ''' + coalesce(z.[name], [InyZbor]) + ''', ' +
    'pv => ' + cast([PiatokVecera] as nvarchar(max)) + ', ' +
	'pv2 => ' + cast([PiatokVecera2] as nvarchar(max)) + ', ' +
	'sr => ' + cast([SobotaRanajky] as nvarchar(max)) + ', ' +
	'so => ' + cast([SobotaObed] as nvarchar(max)) + ', ' +
	'sv => ' + cast([SobotaVecera] as nvarchar(max)) + ', ' +
	'sv2 => ' + cast([SobotaVecera2] as nvarchar(max)) + ', ' +
	'nr => ' + cast([NedelaRanajky] as nvarchar(max)) + ', ' +
	'no => ' + cast([NedelaObed] as nvarchar(max)) + ', ' +
	'idTShirt => ' + cast(coalesce([idTricko], 0) as nvarchar(max)) + ', ' +
	'idTShirtColor => ' + cast(coalesce([idFarbaTricka], 0) as nvarchar(max)) + ', ' +
	'idHoodie => ' + cast(coalesce([idMikina], 0) as nvarchar(max)) + ', ' +
	'idHoodieColor => ' + cast(coalesce([idFarbaMikiny], 0) as nvarchar(max)) + ', ' +
	'qr => ''' + q.[seminare] + '''' +
	'},'
from [dbo].[registracia] r
left join [dbo].[zbor] z on z.[id] = r.[IdZbor]
left join [dbo].[qr] q on q.[id] = r.[id]
--where [id] > 386
order by r.[Priezvisko] asc, r.[Meno] asc
