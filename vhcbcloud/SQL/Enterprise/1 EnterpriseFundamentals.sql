use VHCBSandbox
go


truncate table EnterpriseFundamentals
go


DECLARE @ProjectId int

declare NewCursor Cursor for
select distinct ProjectId
from dbo.Fundamentals_Final2
where ProjectId is not null

open NewCursor
fetch next from NewCursor into @ProjectId
WHILE @@FETCH_STATUS = 0
begin

	if exists(select 1 from dbo.Fundamentals_Final2 where ProjectId = @ProjectId and [Status Pt ID] = 27513)
		insert into EnterpriseFundamentals(ProjectID, FiscalYr, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc)
		select ProjectId,  lv.TypeID FiscalYr, [Type of Planning Work], [Service Provider ID], LeadAdvisorID, 
			[Project Description], [Business Description]
		from dbo.Fundamentals_Final2
		left join lookupvalues lv(nolock) on lv.Description = RIGHT([Project Name], 4)
		where ProjectId = @ProjectId and [Status Pt ID] = 27513 and LookupType = 76
	else if exists(select 1 from dbo.Fundamentals_Final2 where ProjectId = @ProjectId and [Status Pt ID] = 26809)
		insert into EnterpriseFundamentals(ProjectID, FiscalYr, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc)
		select ProjectId,  lv.TypeID FiscalYr, [Type of Planning Work], [Service Provider ID], LeadAdvisorID, 
			[Project Description], [Business Description]
		from dbo.Fundamentals_Final2
		left join lookupvalues lv(nolock) on lv.Description = RIGHT([Project Name], 4)
		where ProjectId = @ProjectId and [Status Pt ID] = 26809 and LookupType = 76
	else if exists(select 1 from dbo.Fundamentals_Final2 where ProjectId = @ProjectId and [Status Pt ID] = 27514)
		insert into EnterpriseFundamentals(ProjectID, FiscalYr, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc)
		select ProjectId,  lv.TypeID FiscalYr, [Type of Planning Work], [Service Provider ID], LeadAdvisorID, 
			[Project Description], [Business Description]
		from dbo.Fundamentals_Final2
		left join lookupvalues lv(nolock) on lv.Description = RIGHT([Project Name], 4)
		where ProjectId = @ProjectId and [Status Pt ID] = 27514 and LookupType = 76
	else if exists(select 1 from dbo.Fundamentals_Final2 where ProjectId = @ProjectId and [Status Pt ID] = 27515)
		insert into EnterpriseFundamentals(ProjectID, FiscalYr, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc)
		select ProjectId,  lv.TypeID FiscalYr, [Type of Planning Work], [Service Provider ID], LeadAdvisorID, 
			[Project Description], [Business Description]
		from dbo.Fundamentals_Final2
		left join lookupvalues lv(nolock) on lv.Description = RIGHT([Project Name], 4)
		where ProjectId = @ProjectId and [Status Pt ID] = 27515 and LookupType = 76
	else
	   print 'nothing'

FETCH NEXT FROM NewCursor INTO @ProjectId
END

Close NewCursor
deallocate NewCursor
go
