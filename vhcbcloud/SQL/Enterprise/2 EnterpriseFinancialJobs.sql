use VHCB
go


begin tran

truncate table EnterpriseFinancialJobs
go

insert into EnterpriseFinancialJobs(ProjectID, StatusPt, MSDate, Year, GrossSales, Netincome, FamilyFTE, NonFamilyFTE, Networth)
select ProjectId,  [Status Pt ID], [Fundamentals- As of Date], RIGHT([Project Name], 4) FiscalYr, [Gross Sales], [NetIncome], isnull([Family FTE], 0), 
	isnull([NonFamily FTE], 0), isnull([NetWorth], 0)
from dbo.Fundamentals_Final2
where ProjectId is not null --and projectid = 10053
go

select * from EnterpriseFinancialJobs
go

commit


begin tran

update j set [MSDate] = f.[Fundamentals- As of Date]
from EnterpriseFinancialJobs j(nolock)
join [dbo].[Fundamentals_Final2] f(nolock) on f.ProjectId = j.ProjectId and f.[Status Pt ID] = j.[StatusPt]


commit