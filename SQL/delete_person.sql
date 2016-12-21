declare @email nvarchar(max);

set @email = 'jaroban@yahoo.com';

--select *
delete
from [konfera].[dbo].[registracia]
where email = @email;

--select *
delete
from [konfera].[dbo].[account]
where email = @email;

--select *
delete
from [konfera].[dbo].[email]
where address = @email;



