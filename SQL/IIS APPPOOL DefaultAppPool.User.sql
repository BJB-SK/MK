USE [konfera]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 11/28/2018 11:49:00 PM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
