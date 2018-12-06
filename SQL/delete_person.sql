declare @email nvarchar(max);


set @email = 'dummy@dummy.com';

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



