/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
FROM [konfera].[dbo].[registracia] r 
left join dbo.tricko t on r.idMikina = t.id
where idMikina is not null and dtPrisli is null

SELECT t.name, 
	case when r.idFarbaTricka = 0 then 'zlta'
		 when r.idFarbaTricka = 1 then 'ruzova'
		 end,
	count(*)
FROM [konfera].[dbo].[registracia] r 
left join dbo.tricko t on r.idTricko = t.id
where idTricko is not null and dtPrisli is null
group by t.name, r.idFarbaTricka

SELECT t.name, count(*)
FROM [konfera].[dbo].[registracia] r 
left join dbo.tricko t on r.idTricko = t.id
where idTricko is not null and dtPrisli is null
group by t.name

SELECT count(*)
FROM [konfera].[dbo].[registracia] r 
left join dbo.tricko t on r.idTricko = t.id
where idTricko is not null and dtPrisli is null
