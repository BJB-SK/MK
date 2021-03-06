USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_donation] (idAccount, amount, dtModified)
AS
select
    idAccount,
    cast(sum(d.amount / c.rate) as decimal(18, 4)) as amount,
    min(dtModified) as dtModified
from donation d
inner join currency c on c.id = d.idCurrency
group by idAccount;

GO
