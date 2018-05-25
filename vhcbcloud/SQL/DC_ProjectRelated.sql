use PTConvert
go

truncate table VHCB.dbo.ProjectRelated
go

insert into VHCB.dbo.ProjectRelated(ProjectID, RelProjectID)
select mp1.ProjectId, mp2.ProjectId as RelProjectID
from ptrelatedproj rel(nolock)
join MasterProj mp1(nolock) on mp1.[key] = rel.projkey
join MasterProj mp2(nolock) on mp2.Proj_num = rel.relnum

select * from VHCB.dbo.ProjectRelated
go

