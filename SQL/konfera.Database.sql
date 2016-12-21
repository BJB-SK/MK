USE [master]
GO
/****** Object:  Database [konfera]    Script Date: 21.12.2016 16:42:48 ******/
CREATE DATABASE [konfera]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'konfera', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\konfera.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'konfera_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\konfera_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [konfera] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [konfera].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [konfera] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [konfera] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [konfera] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [konfera] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [konfera] SET ARITHABORT OFF 
GO
ALTER DATABASE [konfera] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [konfera] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [konfera] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [konfera] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [konfera] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [konfera] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [konfera] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [konfera] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [konfera] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [konfera] SET  DISABLE_BROKER 
GO
ALTER DATABASE [konfera] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [konfera] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [konfera] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [konfera] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [konfera] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [konfera] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [konfera] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [konfera] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [konfera] SET  MULTI_USER 
GO
ALTER DATABASE [konfera] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [konfera] SET DB_CHAINING OFF 
GO
ALTER DATABASE [konfera] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [konfera] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [konfera] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [konfera] SET QUERY_STORE = OFF
GO
USE [konfera]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE [konfera] SET  READ_WRITE 
GO
