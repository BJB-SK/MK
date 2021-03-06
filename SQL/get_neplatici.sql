/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 konfera.dbo.registracia.id
      ,konfera.dbo.payment.idAccount
      ,[meno]
      ,[priezvisko]
      ,konfera.dbo.registracia.email
      ,[poznamka]
      ,[idSluziaci]
      ,[idDobrovolnik]
      ,[dtPrisli]
  FROM [konfera].[dbo].[registracia] left join  konfera.dbo.payment on konfera.dbo.registracia.idAccount=konfera.dbo.payment.idAccount 
  where konfera.dbo.payment.idAccount is null and idSluziaci is null and (idZbor <> 62 or idZbor is null) and meno like '%Kat%'