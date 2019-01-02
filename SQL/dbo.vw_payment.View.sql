USE [konfera]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_payment] (idAccount, amount, dtCreated)
AS
select 
    idAccount,
    sum(p.amount / c.rate) as amount,
    min(dtCreated) as dtCreated
from payment p
inner join currency c on c.id = p.idCurrency
group by idAccount;
GO
