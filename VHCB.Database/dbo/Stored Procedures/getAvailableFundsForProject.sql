
Create procedure getAvailableFundsForProject  
as
begin

	select distinct p.projectid, proj_num, round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 and tr.LkTransaction = 238
	group by p.projectid, proj_num
	order by proj_num 
end