use vhcb
go

/*
	Inserting data into two tables
	1.ProjectEvent
	2.EnterpriseFinancialJobs
*/
select * from EnterpriseFinancialJobs
go


begin tran

--ProjectEvent

insert into ProjectEvent(ProjectID, EventID, Prog, Date)
select p.ProjectID, 26848, 148, [DateCreated]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where ImpGrantApplied = 1

insert into ProjectEvent(ProjectID, EventID, Prog, Date)
select p.ProjectID, 26518, 148, [DateCreated]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where ImpGrantAward = 1

insert into ProjectEvent(ProjectID, EventID, Prog, Date)
select p.ProjectID, 26520, 148, [DateCreated]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where ImpGrantAward = 0

insert into ProjectEvent(ProjectID, EventID, Prog, Date)
select p.ProjectID, 26525, 148, g.[DateModified]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where ImpGrantComplete = 1

insert into ProjectEvent(ProjectID, EventID, Prog, Date)
select p.ProjectID, 26766, 148, g.[DateModified]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where SiteVisitComplete = 1

--EnterpriseFinancialJobs

insert into EnterpriseFinancialJobs(ProjectID, StatusPt, MSDate)
select p.ProjectID, 27513, g.[DateModified]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where ImpGrantComplete = 1

insert into EnterpriseFinancialJobs(ProjectID, StatusPt, MSDate)
select p.ProjectID, 27516, g.[DateModified]
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num
where SiteVisitComplete = 1


--commit

begin tran

insert into EnterpriseFinancialJobs(ProjectID, StatusPt, GrossSales, Netincome, FamilyFTE, NonFamilyFTE, Networth, [MSDate])
select p.ProjectID, 26809, 
	FinGrossIncomeLastyr, 
	replace(replace(replace(isnull(FinNetIncomeLastyr, 0), '(', '-'), ')', ''), '$', '') as FinNetIncomeLastyr,
	AveNumNonHouseEmpsFT, AveNumHouseEmpsFT, 
	replace(replace(replace(isnull(FinNetWorth, 0), '(', '-'), ')', ''), '$', '') as FinNetWorth, FinRptDate
from  [FFVConvert].[dbo].[ImpGrants]  g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num

--select * from EnterpriseFinancialJobs order by 1 desc

--rollback
--commit

