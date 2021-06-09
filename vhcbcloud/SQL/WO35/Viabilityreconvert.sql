select p.projectId,* 
from dbo.Viabilityreconvert v(nolock)
join project p(nolock) on p.proj_num = v.[project Number]


begin tran

truncate table dbo.EnterpriseAcres
go

insert into EnterpriseAcres(ProjectID, AcresInProduction, AcresOwned, AcresLeased, AccessAcres)
select p.projectId, [Acres In Production], [Acres Owned], [Acres Leased], [Access Acres (for conversion)]
from dbo.Viabilityreconvert v(nolock)
join project p(nolock) on p.proj_num = v.[project Number]

select * from dbo.EnterpriseAcres

commit
select * 
update e set LeadAdvisor = v.[Lead Advisor - Acct #]
from EnterpriseFundamentals e(nolock)
join project p(nolock) on e.ProjectID = p.ProjectId
join dbo.Viabilityreconvert v(nolock) on  p.proj_num = v.[project Number]



select * 
--update e set OtherNames = v.[Owner/Operator]
from EnterprisePrimeProduct e(nolock)
join project p(nolock) on e.ProjectID = p.ProjectId
join dbo.Viabilityreconvert v(nolock) on  p.proj_num = v.[project Number]