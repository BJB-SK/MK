USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @idUser                     [int] = null,
    @meno                       [nvarchar](max),
    @priezvisko                 [nvarchar](max),
    @email                      [nvarchar](max),
    @telefon                    [nvarchar](max),
    @idZbor                     [int] = null,
    @inyZbor                    [nvarchar](max),
    
    @piatokVecera               [bit],
    @piatokVecera2              [bit],
    @idUbytovaniePiatokSobota   [int] = null,
    
    @sobotaRanajky              [bit],
    @sobotaObed                 [bit],
    @sobotaVecera               [bit],
    @sobotaVecera2              [bit],
    @idUbytovanieSobotaNedela   [int] = null,

    @nedelaRanajky              [bit],
    @nedelaObed                 [bit],
    
    @sach                       [bit],
    @pingPong                   [bit],
    @idTricko                   [int] = null,
    @idSluziaci                 [int] = null,
    @idDobrovolnik              [int] = null,
    @poznamka                   [nvarchar](max),
    @registracny                [decimal](18, 4)
AS
BEGIN
    update [dbo].[registracia] set 
        [meno] = @meno,
        [priezvisko] = @priezvisko,
        [email] = @email,
        [telefon] = @telefon,
        [idZbor] = @idZbor,
        [inyZbor] = @inyZbor,
        [piatokVecera] = @piatokVecera,
        [piatokVecera2] = @piatokVecera2,
        [idUbytovaniePiatokSobota] = @idUbytovaniePiatokSobota,
        [sobotaRanajky] = @sobotaRanajky,
        [sobotaObed] = @sobotaObed,
        [sobotaVecera] = @sobotaVecera,
        [sobotaVecera2] = @sobotaVecera2,
        [idUbytovanieSobotaNedela] = @idUbytovanieSobotaNedela,
        [nedelaRanajky] = @nedelaRanajky,
        [nedelaObed] = @nedelaObed,
        [sach] = @sach,
        [pingPong] = @pingPong,
        [idTricko] = @idTricko,
        [poznamka] = @poznamka,
        [idSluziaci] = @idSluziaci,
        [idDobrovolnik] = @idDobrovolnik,
        [registracnyPoplatok] = @registracny
    where id = @idUser;
END


GO
