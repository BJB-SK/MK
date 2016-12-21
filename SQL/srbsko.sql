update r set IdZbor = 71, Poznamka = ''
-- select *
from [konfera].[dbo].[registracia] r
where IdZbor is null and poznamka like '%srbsko%'