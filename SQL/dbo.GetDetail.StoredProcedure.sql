USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDetail]
    @idAttendee [int]
AS
BEGIN
    with costOfAccount as
    (
        select idAccount, sum(amount) as amount
        from vw_cost
        group by idAccount
    )
    select
        r.[id], [firstName], [lastName], [email], [phoneNumber], 
        [idChurch], r.[otherChurch],
        [note], r.[dtModified], [dtShowedUp],
        [idJob],
        p.[dtCreated],
        coalesce(p.[amount], 0),
        coalesce(c.[amount], 0),
        coalesce(d.[amount], 0),
        coalesce(p.[amount], 0) - coalesce(c.[amount], 0) - coalesce(d.[amount], 0),
        extraFee
    from [dbo].[attendee] r
    left join [dbo].[vw_payment] p on p.[idAccount] = r.[idAccount]
    left join costOfAccount c on c.[idAccount] = r.[idAccount]
    left join [dbo].[vw_donation] d on d.[idAccount] = r.[idAccount]
    where r.[id] = @idAttendee;
    
	select p.id, p.name, p.price, p.max, p.code, p.idProductCategory, 
		(select count(*) from dbo.attendee_product pp where pp.idProduct = p.id) as ordered
	from dbo.product p;

	select id, idProduct
	from dbo.attendee_product
	where idAttendee = @idAttendee;

    declare @idAccount int;
    select @idAccount = [idAccount] 
    from [dbo].[attendee]
    where [id] = @idAttendee;
    
    select [id], [firstName] + ' ' + [lastName]
    from [dbo].[attendee]
    where [id] <> @idAttendee and [idAccount] = @idAccount
    order by 2 asc;
END
GO
