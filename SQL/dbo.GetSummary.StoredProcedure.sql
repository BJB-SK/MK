USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSummary]
AS
BEGIN
	-- products
    select 
		p.name,
		p.max as available,
		(select count(*) from dbo.attendee_product ap where ap.idProduct = p.id) as ordered,
		(
            select count(*) 
            from dbo.attendee_product ap 
			inner join dbo.attendee a on a.id = ap.idAttendee
			left join [dbo].[job_productCategory] jpc on jpc.idJob = a.idJob and jpc.idProductCategory = p.idProductCategory
			left join [dbo].[vw_payment] pm on pm.idAccount = a.idAccount
			where
				ap.idProduct = p.id and (
					jpc.id is not null or
					pm.dtCreated is not null or
					idChurch = 62)
        ) as paid_for
    from dbo.product p
	order by p.id asc;

    -- attendees
    select count(*)
    from [dbo].[attendee];

	-- showed up
	select count(*)
    from [dbo].[attendee]
	where dtShowedUp is not null;

    -- expecting money
    select sum(amount)
    from vw_cost;
    
    -- paid by people
    select sum(amount)
    from vw_payment;
    
    -- sluziaci
    select j.name, 
		(select count(*) from attendee r where r.idJob = j.id),
		j.maxCount
    from job j
    order by j.name;
    
    -- poznamka
    select [note]
    from [dbo].[attendee]
    where [note] <> ''
    order by dtModified asc;
    
    -- by church
    select coalesce(z.[name], r.[otherChurch]) as church, COUNT(*) as count
    from [dbo].[attendee] r
    left join [dbo].[church] z on z.id = r.idChurch
    group by coalesce(z.[name], r.[otherChurch])
    order by count desc, church asc;
END
GO
