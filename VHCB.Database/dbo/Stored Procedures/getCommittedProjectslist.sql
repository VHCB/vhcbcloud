CREATE procedure getCommittedProjectslist  
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 --and tr.LkTransaction = 238--and tr.lkstatus = 262--

	and tr.RowIsActive=1 and pn.defname=1
	group by p.projectid, proj_num
	order by proj_num 
end