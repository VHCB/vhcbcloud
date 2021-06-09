use VHCB
go


delete from dbo.Projectevent where prog = 148
go

insert into dbo.Projectevent([ProjectID], [Prog], [EventID], [ProgEventID], [Date])
select ProjectId, 148, 0, [ProgramMilestoneID], 
case when ProgramMilestoneId= 26245 then [Milestone Date] else [DateModified] end
from dbo.Fundamentals_Final2
where ProjectId is not null --and projectid = 10053
go

insert into dbo.Projectevent([ProjectID], [Prog], [EventID], [ProgEventID], [Date])
select ProjectId, 148, 0, 
case when [enrolled=1 referred=2] = 1 then 29747 
		when  [enrolled=1 referred=2] = 2 then 29746 
		else null end, 
getdate()
from dbo.Fundamentals_Final2
where ProjectId is not null and [enrolled=1 referred=2] is not null
go

select * from  dbo.Projectevent where prog = 148
go