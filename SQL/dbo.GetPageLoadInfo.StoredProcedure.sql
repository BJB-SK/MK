USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPageLoadInfo]
AS
BEGIN
    select id, name, rate, paymentInfo from dbo.currency order by id asc;
    select id, name from dbo.church order by name asc;
    
	select f.id, f.dtFrom, f.dtTo, p.price, f.online, f.comment, p.code
    from dbo.fee f
	inner join dbo.product p on p.id = f.idProduct
    order by id asc;

    with counts as
    (
        select idJob as id, count(*) as n
        from dbo.attendee
        group by idJob
    )
    select s.id, name, tooltip,
        cast(case when coalesce(c.n, 0) < coalesce(maxCount, 10000) then 1 else 0 end as bit) as allowed,
        [public]
    from job s
    left join counts c on c.id = s.id
    order by s.name asc;

	select idJob, idProductCategory
	from dbo.job_productCategory;

	select p.id, p.name, p.price, p.max, p.code, p.idProductCategory, 
		(select count(*) from dbo.attendee_product pp where pp.idProduct = p.id) as ordered
	from dbo.product p;
END
GO
