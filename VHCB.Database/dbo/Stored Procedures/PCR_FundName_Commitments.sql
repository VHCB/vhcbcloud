CREATE procedure PCR_FundName_Commitments
as
begin
	select distinct name, f.FundId from fund f(nolock)
	join Detail d(nolock) on d.FundId = f.FundId
	join trans tr (nolock) on tr.TransId = d.TransId
	where tr.LkTransaction = 238
	order by f.FundId
end