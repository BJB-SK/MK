/****** Script for SelectTopNRows command from SSMS  ******/
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