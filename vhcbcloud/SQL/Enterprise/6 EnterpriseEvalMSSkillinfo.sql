use vhcbsandbox
go


select * from [dbo].[Both Evals and SkillInfo]

--alter table EvalSkillInfo_TOBE_Converted add ProjectId int

select * from [dbo].[Both Evals and SkillInfo] ski(nolock)
join project p(nolock) on p.proj_num = ski.[Project #]
--183 rows


--update ski set ski.ProjectId = p.ProjectId
--from EvalSkillInfo_TOBE_Converted ski(nolock)
--join project p(nolock) on p.proj_num = ski.[Project #]
----1156 rows updated
go

begin tran

truncate table EnterpriseEvalMSSkillinfo
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26570 as SkillType,
[SkillType=26570 Pre] prelevl,
[SkillType=26570 Post] potlevel
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26577 as SkillType,
[SkillType=26577 Pre],
[SkillType=26577 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26575 as SkillType,
[SkillType=26575 Pre],
[SkillType=26575 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26572 as SkillType,
[SkillType=26572 Pre],
[SkillType=26572 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26571 as SkillType,
[SkillType=26571 Pre],
[SkillType=26571 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26574 as SkillType,
[SkillType=26574 Pre],
[SkillType=26574 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26573 as SkillType,
[SkillType=26573 Pre],
[SkillType=26573 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
26576 as SkillType,
[SkillType=26576 Pre],
[SkillType=26576 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30870 as SkillType,
[SkillType=30870 Pre],
[SkillType=30870 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30869 as SkillType,
[SkillType=30869 Pre],
[SkillType=30869 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30868 as SkillType,
[SkillType=30868 Pre],
[SkillType=30868 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30867 as SkillType,
[SkillType=30867 Pre],
[SkillType=30867 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30866 as SkillType,
[SkillType=30866 Pre],
[SkillType=30866 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go

insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
select spt.EnterpriseEvalID, 
30865 as SkillType,
[SkillType=30865 Pre],
[SkillType=30865 Post]
from dbo.EnterpriseEvalStatusPt spt(nolock)
join [dbo].[Both Evals and SkillInfo] ski(nolock) on ski.ProjectId = spt.ProjectId and ski.[Statuspt TypeID] = spt.StatusPt
go


commit
select * from EnterpriseEvalMSSkillinfo