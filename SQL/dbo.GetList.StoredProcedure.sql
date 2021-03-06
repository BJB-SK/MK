USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetList]
    @name           [nvarchar](max),
    @idChurch       [int],
	@idProduct      [int],
	@idJob          [int],
    @from           [nvarchar](max),
    @to             [nvarchar](max),
    @arrived        [bit],
    @notArrived     [bit]
AS
BEGIN
    with costOfAccount as
    (
        select idAccount, sum(amount) as amount
        from vw_cost
        group by idAccount
    )
    select 
        r.[id],
        r.[idAccount],
        [firstName],
        [lastName],
        coalesce(z.[name], r.[otherChurch]),
        (coalesce(p.[amount], 0) - coalesce(c.[amount], 0) - coalesce(d.[amount], 0)) as diff,
        [dtShowedUp]
    from [dbo].[attendee] r
    left join [dbo].[church] z on z.[id] = r.[idChurch]
    left join [dbo].[vw_payment] p on p.[idAccount] = r.[idAccount]
    left join costOfAccount c on c.[idAccount] = r.[idAccount]
    left join [dbo].[vw_donation] d on d.[idAccount] = r.[idAccount]
    where
        (@name is null or @name = '' or [firstName] + ' ' + [lastName] like '%' + @name + '%' or [email] like '%' + @name + '%') and
        (@idChurch is null or @idChurch = 0 or [idChurch] = @idChurch) and
		(@idProduct is null or @idProduct = 0 or exists(select * from dbo.attendee_product ap where ap.idAttendee = r.id and ap.idProduct = @idProduct)) and
		(@idJob is null or @idJob = 0 or [idJob] = @idJob) and
        (@from is null or @from = '' or @from <= left([firstName], 1)) and
        (@to is null or @to = '' or left([firstName], 1) <= @to) and
        ((@arrived = 1 and [dtShowedUp] is not null) or
         (@notArrived = 1 and [dtShowedUp] is null))
    order by [firstName] asc, [lastName] asc;
END
GO
