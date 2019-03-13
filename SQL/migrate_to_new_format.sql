delete from dbo.attendee_product

declare @idProduct int;

-- food

select @idProduct = [id] from dbo.product where code = 'pv';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where piatokVecera = 1;

select @idProduct = [id] from dbo.product where code = 'pv2';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where piatokVecera2 = 1;

select @idProduct = [id] from dbo.product where code = 'sr';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where sobotaRanajky = 1;

select @idProduct = [id] from dbo.product where code = 'so';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where sobotaObed = 1;

select @idProduct = [id] from dbo.product where code = 'sv';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where sobotaVecera = 1;

select @idProduct = [id] from dbo.product where code = 'sv2';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where sobotaVecera2 = 1;

select @idProduct = [id] from dbo.product where code = 'nr';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where nedelaRanajky = 1;

select @idProduct = [id] from dbo.product where code = 'no';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where nedelaObed = 1;

-- lodging
declare @idProduct int;

select @idProduct = [id] from dbo.product where code = 'pst';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovaniePiatokSobota = 0;

select @idProduct = [id] from dbo.product where code = 'pstt';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovaniePiatokSobota = 1;

select @idProduct = [id] from dbo.product where code = 'psint1';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovaniePiatokSobota = 2;

select @idProduct = [id] from dbo.product where code = 'psint2';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovaniePiatokSobota = 3;

select @idProduct = [id] from dbo.product where code = 'snt';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovanieSobotaNedela = 0;

select @idProduct = [id] from dbo.product where code = 'sntt';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovanieSobotaNedela = 1;

select @idProduct = [id] from dbo.product where code = 'snint1';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovanieSobotaNedela = 2;

select @idProduct = [id] from dbo.product where code = 'snint2';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where idUbytovanieSobotaNedela = 3;

-- freebies
insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 1
FROM [dbo].[volunteer] where stravaZadarmo = 1;

insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 2
FROM [dbo].[volunteer] where internatZadarmo = 1;

insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 3
FROM [dbo].[volunteer] where trickoZadarmo = 1;

insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 4
FROM [dbo].[volunteer] where mikinaZadarmo = 1;

insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 6
FROM [dbo].[volunteer] where registraciaZadarmo = 1;

-- sports
declare @idProduct int;

select @idProduct = [id] from dbo.product where code = 'chess';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where chess = 1;

select @idProduct = [id] from dbo.product where code = 'pingPong';
insert into dbo.attendee_product (idAttendee, idProduct)
SELECT [id], @idProduct
FROM [dbo].[attendee] where pingPong = 1;

-- registration
insert into dbo.attendee_product (idAttendee, idProduct)
select
    a.id,
    pr.id
from dbo.attendee a
left join dbo.vw_payment p on p.idAccount = a.idAccount
left join dbo.fee fp on coalesce(fp.dtPaymentFrom, p.dtCreated, getdate()) <= coalesce(p.dtCreated, getdate()) and
                         coalesce(p.dtCreated, getdate()) <= fp.dtPaymentTo
inner join dbo.product pr on pr.price = fp.amount and pr.idProductCategory = 6;




insert into [dbo].[volunteer]
([name],[tooltip],[maxCount],[public])
select [name], [tooltip], 10, 1
FROM [konfera].[dbo].[service]


update a set
idVolunteer = v.id
from [konfera].[dbo].[attendee] a
inner join dbo.service s on s.id = a.idService
inner join dbo.volunteer v on v.name = s.name
where a.idVolunteer = 1 and a.idService is not null

insert into dbo.volunteer_productCategory (idVolunteer, idProductCategory)
SELECT [id], 3
FROM [dbo].[volunteer] where maxCount = 10;
