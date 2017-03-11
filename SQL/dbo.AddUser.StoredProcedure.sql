USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser]
    @meno                       [nvarchar](max),
    @priezvisko                 [nvarchar](max),
    @email                      [nvarchar](max),
    @telefon                    [nvarchar](max),
    @idZbor                     [int] = null,
    @inyZbor                    [nvarchar](max),
    @sach                       [bit],
    @pingPong                   [bit],
    @piatokVecera               [bit],
    @piatokVecera2              [bit],
    @idUbytovaniePiatokSobota   [int],
    @sobotaRanajky              [bit],
    @sobotaObed                 [bit],
    @sobotaVecera               [bit],
    @sobotaVecera2              [bit],
    @idUbytovanieSobotaNedela   [int],
    @nedelaRanajky              [bit],
    @nedelaObed                 [bit],
    @idSluziaci                 [int] = null,
    @idDobrovolnik              [int] = null,
    @poznamka                   [nvarchar](max),
    @donation                   [decimal](18,4),
    @registracny                [decimal](18,4),
    @newId                      [int] output
AS
BEGIN
    declare @now datetime = getutcdate();

    insert into [dbo].[account] 
        ([email], [dtCreated])
    values 
        (@email, @now);

    declare @idAccount int = scope_identity();
    
    if coalesce(@donation, 0) > 0 
    begin
        insert into [dbo].[donation] 
            ([idAccount], [amount], [idCurrency], [dtModified])
        values
            (@idAccount, @donation, 1, @now);
    end

    insert into [dbo].[registracia]
        ([idAccount], [meno], [priezvisko], [email], [telefon], [idZbor], [inyZbor], 
        [piatokVecera], [piatokVecera2], [idUbytovaniePiatokSobota],
        [sobotaRanajky], [sobotaObed], [sobotaVecera], [sobotaVecera2], [idUbytovanieSobotaNedela],
        [nedelaRanajky], [nedelaObed], 
        [sach], [pingPong], [idSluziaci], [idDobrovolnik], [poznamka], [registracnyPoplatok], [dtModified])
    values
        (@idAccount, @meno, @priezvisko, @email, @telefon, @idZbor, @inyZbor, 
        @piatokVecera, @piatokVecera2, @idUbytovaniePiatokSobota,
        @sobotaRanajky, @sobotaObed, @sobotaVecera, @sobotaVecera2, @idUbytovanieSobotaNedela,
        @nedelaRanajky, @nedelaObed, 
        @sach, @pingPong, @idSluziaci, @idDobrovolnik, @poznamka, @registracny, @now);
        
    set @newId = scope_identity();
    
END


GO
