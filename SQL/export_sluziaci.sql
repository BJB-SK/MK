SELECT        dbo.sluziaci.name AS Sluzba, dbo.registracia.meno, dbo.registracia.priezvisko, dbo.registracia.email, dbo.registracia.telefon
FROM            dbo.registracia INNER JOIN
                         dbo.sluziaci ON dbo.registracia.idSluziaci = dbo.sluziaci.id
WHERE        (dbo.registracia.idSluziaci <> 1)

SELECT [konfera].[dbo].[dobrovolnik].name 
	  ,[meno]
      ,[priezvisko]
      ,[email]
      ,[telefon]
	  ,[konfera].[dbo].zbor.name
	  ,poznamka
  FROM [konfera].[dbo].[registracia] left join [konfera].[dbo].[dobrovolnik] ON idDobrovolnik=[konfera].[dbo].[dobrovolnik].id left join [konfera].[dbo].[zbor] on idZbor=[konfera].[dbo].[zbor].id
  where idSluziaci=1
  order by idDobrovolnik