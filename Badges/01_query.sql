-- save results as 02_export.pl (delete final comma, add [ ] around the list)
select 
	'{ ' +
	'id => ' + cast(r.[id] as nvarchar(max)) + ', ' +
	'name => ''' + [firstName] + ''', ' +
	'church => ''' + coalesce(z.[name], [otherChurch]) + ''', ' +
    'products => {' +
        replace(
            stuff(
                coalesce((
                    select ', ''' + code + ''' => 1'
                    from attendee_product ap 
                    inner join product p on p.id = ap.idProduct
                    where ap.idAttendee = r.id
                    for xml path('')),
                    ' '
                ),
                1, 1, ''),
            '&gt;', '>')
        + ' } ' +
	'},'
from [dbo].[attendee] r
left join [dbo].[church] z on z.[id] = r.[idChurch]
order by r.[firstName] asc;
