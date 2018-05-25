use PTConvert
go

--ProjectVHCBPriorities
--ProjectInteragency

truncate table vhcb.dbo.ProjectVHCBPriorities
go


insert into vhcb.dbo.ProjectVHCBPriorities(ProjectID, LkVHCBPriorities)
select mp. [ProjectId], 27443
from [dbo].[pthousingproj] pthproj(nolock)
join [dbo].[MasterProj] mp(nolock) on pthproj.[key] = mp.[key]
where histelem  = 1
go

select * from vhcb.dbo.ProjectVHCBPriorities
go


truncate table vhcb.dbo.ProjectInteragency
go

insert into vhcb.dbo.ProjectInteragency(ProjectID, [LkInteragency], [Numunits])
select mp. [ProjectId], 205, 0
from [dbo].[pthousingproj] pthproj(nolock)
join [dbo].[MasterProj] mp(nolock) on pthproj.[key] = mp.[key]
where [hdntnrev]  = 1
go

insert into vhcb.dbo.ProjectInteragency(ProjectID, [LkInteragency], [Numunits])
select mp. [ProjectId], 26819, 0
from [dbo].[pthousingproj] pthproj(nolock)
join [dbo].[MasterProj] mp(nolock) on pthproj.[key] = mp.[key]
where hnegrev  = 1
go

select * from vhcb.dbo.ProjectInteragency
go
