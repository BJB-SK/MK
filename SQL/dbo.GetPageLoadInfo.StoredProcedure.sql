USE [konfera]
GO
/****** Object:  StoredProcedure [dbo].[GetPageLoadInfo]    Script Date: 21.12.2016 16:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPageLoadInfo]
AS
BEGIN
    select id, name, rate, paymentInfo from currency order by id asc;
    select id, name from tricko order by id asc;
    select id, name from zbor order by name asc;
    select id, name, tooltip from dobrovolnik order by name asc;
    
    with counts as
    (
        select idSluziaci as id, count(*) as n
        from registracia
        group by idSluziaci
    )
    select s.id, name, tooltip, registraciaZadarmo, trickoZadarmo, stravaZadarmo, internatZadarmo,
        cast(case when coalesce(c.n, 0) < coalesce(maxCount, 10000) then 1 else 0 end as bit) as allowed,
        [public]
    from sluziaci s
    left join counts c on c.id = s.id
    order by s.name asc;
    
    select id, dtFrom, dtTo, amount, online, comment
    from poplatok
    order by id asc;
END



GO
