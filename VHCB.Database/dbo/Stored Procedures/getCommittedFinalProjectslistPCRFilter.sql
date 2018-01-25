CREATE  procedure [dbo].[getCommittedFinalProjectslistPCRFilter]  
(
	@filter varchar(20)
)
as
begin

	select distinct  proj_num,p.projectid, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	join projectcheckreq pcr on pcr.Projectid = p.projectid
	where defname = 1 and tr.lkstatus = 261 --and tr.LkTransaction = 238--and tr.lkstatus = 262--
	and 
	(select count(*) from ProjectCheckReqQuestions where ProjectCheckReqID = pcr.ProjectCheckReqID and Approved = 0)>0
/**	and 
	pcr.Voucher# is not null **/
	
	and tr.RowIsActive=1 and pn.defname=1 and p.Proj_num like @filter +'%'	
	group by p.projectid, proj_num
	order by proj_num 
end