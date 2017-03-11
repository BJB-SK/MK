select 
    r.[Id], [Meno] + ' ' + [Priezvisko],
    coalesce(z.[name], [InyZbor]),
    [PiatokVecera],[PiatokVecera2],
    [SobotaRanajky],[SobotaObed],[SobotaVecera],[SobotaVecera2],
    [NedelaRanajky],[NedelaObed],
    coalesce([idTricko], 0)
from [dbo].[registracia] r
left join [dbo].[zbor] z on z.[id] = r.[IdZbor]
--where [id] > 386
order by r.[Priezvisko] asc, r.[Meno] asc;