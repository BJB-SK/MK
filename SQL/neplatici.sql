/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
UPDATE r set asiNepridu=1
  FROM [konfera].[dbo].[registracia] r left join  konfera.dbo.payment on r.idAccount=konfera.dbo.payment.idAccount 
  where konfera.dbo.payment.idAccount is null and (idZbor <> 62 or idZbor is null) and idSluziaci is null