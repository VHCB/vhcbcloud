
CREATE procedure getCommittedPendingCashRefundProjectslistByFilter 
(
	@filter varchar(20)
)
as
begin

	select distinct  top 35 p.Proj_num
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where pn.defname = 1 and tr.lkstatus = 261 and tr.LkTransaction = 237
		and tr.RowIsActive=1 and p.Proj_num like @filter +'%'	
	order by p.proj_num 
end