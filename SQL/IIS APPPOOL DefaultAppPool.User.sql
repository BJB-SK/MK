USE [konfera]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 21.12.2016 16:42:48 ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
