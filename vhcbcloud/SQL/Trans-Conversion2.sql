use PTConvert
go

truncate table Detail
go

insert into Detail(TransId, FundId, LkTransType, ProjectID, Amount)
select t.TransId, ff.FundId,
case Grln
	when 'Grant' then 241
	when 'Loan' then 242
	else 0
end as LKTransType,
t.ProjectID, d.Amount
from Trans t(nolock)
join ptdetail d(nolock) on d.[Transkey] = t.[TRANSKEY]
join Fund ff(nolock) on  ff.FundKey = d.[FundKey]
where  [Grln] is not null


update Trans set Balanced = dbo.CheckIsBalanceZero(TransId)
go


select * from Fund f(nolock)
join dbo.['ptfund9-25$'] pt(nolock) on f.account = pt.account


select * from dbo.['ptfund9-25$']

select distinct GRLN from detailtest$ d(nolock)

select * from Detail

select * from [dbo].[LookupValues] where TypeID = 242