
CREATE procedure PCR_Dates
as
begin
	select distinct convert(varchar(10), InitDate) as Date  from [dbo].[ProjectCheckReq]
	union all
	select distinct convert(varchar(10), Date) as Date from [dbo].[Trans]
	order by Date
end