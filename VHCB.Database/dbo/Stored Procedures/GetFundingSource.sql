CREATE procedure [dbo].[GetFundingSource]
as

select FundId, name from Fund
order by DateModified desc, name desc