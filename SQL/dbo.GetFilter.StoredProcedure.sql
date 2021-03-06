USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFilter]
AS
BEGIN
    select id, name
    from dbo.church c
    where exists(select * from dbo.attendee a where a.idChurch = c.id)
    order by name asc;

	select id, name
    from dbo.product p
    where exists(select * from dbo.attendee_product ap where ap.idProduct = p.id)
    order by name asc;

	select id, name
    from dbo.job j
    where exists(select * from dbo.attendee a where a.idJob = j.id)
    order by name asc;
END
GO
