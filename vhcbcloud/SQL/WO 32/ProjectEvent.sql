
use vhcb
go

begin tran

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26518 as EventId, Program, ProjID, [Commitment Date], 'Commitment'
from dbo.ConserveHousingCommits


commit


select * from dbo.ConserveHousingCommits
select * from dbo.ProjectEvent order by 1 desc


select * 
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
begin tran

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2018], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2018] is not null
go

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2017], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2017] is not null 
go

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2016], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2016] is not null
go

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2015], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2015] is not null
go

insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2014], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2014] is not null
go


insert into dbo.ProjectEvent([EventID], [Prog],[ProjectID], [Date], [Note])
select 26664 as EventId, 145, ProjectID, [Date Monitored in 2013], null
from dbo.ConservationDates dt(nolock)
join dbo.project p(nolock) on dt.[Project Number] = p.Proj_num
where [Date Monitored in 2013] is not null
go


select * from dbo.ProjectEvent where projectid = 24 order by 1 desc

--rollback

--commit