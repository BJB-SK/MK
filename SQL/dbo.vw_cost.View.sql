USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_cost] (id, idAccount, amount)
AS
    select a.id, a.idAccount,
		coalesce((
			select sum(p.price) 
			from dbo.attendee_product pp
			inner join dbo.product p on p.id = pp.idProduct
			left join dbo.job_productCategory jpc on 
				jpc.idProductCategory = p.idProductCategory and 
				jpc.idJob = a.idJob
			where idAttendee = a.id and jpc.id is null
		), 0) +
        coalesce(a.extraFee, 0)
    from dbo.attendee a
GO
