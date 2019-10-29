CREATE procedure getCommittedCashRefundProjectslistByFilter 
(
	@filter varchar(20)
) 
as
begin

	select distinct proj_num
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where tr.lkstatus = 261  and tr.LkTransaction = 236 
	and tr.RowIsActive=1 and pn.defname=1	and p.Proj_num like @filter +'%'	
	order by proj_num 
end