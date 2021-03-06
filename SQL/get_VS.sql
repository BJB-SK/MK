/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 konfera.dbo.registracia.id
	  ,konfera.dbo.variabilny.vs
      ,[idAccount]
      ,[meno]
      ,[priezvisko]
      ,konfera.dbo.registracia.email
      ,[telefon]
      ,[idZbor]
      ,[inyZbor]
      ,[piatokVecera]
      ,[piatokVecera2]
      ,[idUbytovaniePiatokSobota]
      ,[sobotaRanajky]
      ,[sobotaObed]
      ,[sobotaVecera]
      ,[sobotaVecera2]
      ,[idUbytovanieSobotaNedela]
      ,[nedelaRanajky]
      ,[nedelaObed]
      ,[sach]
      ,[pingPong]
      ,[idTricko]
      ,[poznamka]
      ,[dtModified]
      ,[idSluziaci]
      ,[idDobrovolnik]
      ,[dtPrisli]
      ,[asiNepridu]
  FROM [konfera].[dbo].[registracia] left join  konfera.dbo.account on konfera.dbo.registracia.idAccount=konfera.dbo.account.id left join konfera.dbo.variabilny on konfera.dbo.account.idVariabilny=konfera.dbo.variabilny.id
  where meno like '%Matej%'