use PTConvert
go

truncate table VHCB.dbo.ProjectFederalProgramDetail
go

truncate table VHCB.dbo.projectFederal
go

DECLARE @ProjectId as int, @ProjectFederalId as int

declare NewCursor Cursor for
select mp. [ProjectId]
from [dbo].[pthousingproj] pthproj(nolock)
join [dbo].[MasterProj] mp(nolock) on pthproj.[key] = mp.[key]
where hchdo  = 1

open NewCursor
fetch next from NewCursor into @ProjectId
WHILE @@FETCH_STATUS = 0
begin

	insert into VHCB.dbo.projectFederal(LkFedProg, ProjectID, NumUnits)
	values(481, @ProjectId, 0)

	set @ProjectFederalId =  SCOPE_IDENTITY()

	insert into VHCB.dbo.ProjectFederalProgramDetail([ProjectFederalId], [CHDO])
	values(@ProjectFederalId, 1)
FETCH NEXT FROM NewCursor INTO @ProjectId
END

Close NewCursor
deallocate NewCursor
go

--select * from VHCB.dbo.projectFederal
--go

update pf set  pf.NumUnits = allFed.[HOME units]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
go

insert into VHCB.Dbo.ProjectFederal(ProjectID, LkFedProg, NumUnits)
select mp.ProjectId, 481, allFed.[HOME units]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
left join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where pf.ProjectID is null and isnull(allFed.[HOME units], 0) != 0 
go

insert into VHCB.Dbo.ProjectFederal(ProjectID, LkFedProg, NumUnits)
select mp.ProjectId, 26224, allFed.[NSP Units]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
left join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where pf.ProjectID is null and isnull(allFed.[NSP Units], 0) != 0 
go


--select * from VHCB.dbo.ProjectFederalProgramDetail
--go


update  pfpd set [LKAffrdPer] = [aff# Period], [IDISClose] = [IDIS Close-Out], [freq] = [Frequency of Inspection],
[Recert] = case [Recert Month] 
	when 'January' then 26263
	when 'February' then 26264
	when 'March' then 26265
	when 'April' then 26266
	when 'May' then 26267
	when 'June' then 26268
	when 'July' then 26269
	when 'August' then 26270
	when 'September' then 26271
	when 'October' then 26272
	when 'November' then 26273
	when 'December' then 26274
end
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
join VHCB.dbo.ProjectFederalProgramDetail pfpd(nolock) on pfpd.ProjectFederalId =  pf.ProjectFederalID
go


insert into VHCB.dbo.ProjectFederalProgramDetail([ProjectFederalId], [LKAffrdPer], [IDISClose], [freq], [Recert])
select  pf.ProjectFederalID, [aff# Period], [IDIS Close-Out], [Frequency of Inspection],
case [Recert Month] 
	when 'January' then 26263
	when 'February' then 26264
	when 'March' then 26265
	when 'April' then 26266
	when 'May' then 26267
	when 'June' then 26268
	when 'July' then 26269
	when 'August' then 26270
	when 'September' then 26271
	when 'October' then 26272
	when 'November' then 26273
	when 'December' then 26274
end as RecertMonth
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
left join VHCB.dbo.ProjectFederalProgramDetail pfpd(nolock) on pfpd.ProjectFederalId =  pf.ProjectFederalID
where pfpd.ProjectFederalId is null
go

truncate table VHCB.dbo.federalunit
go

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 27485, [effic#]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([effic#] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 27486, [SRO]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([SRO] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 26218, [One Beds]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([One Beds] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 26219, [Two Beds]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([Two Beds] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 26220, [Three beds]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull( [Three beds] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 26221, [Four beds]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull( [Four beds] , 0 ) != 0

insert into VHCB.[dbo].[FederalUnit](ProjectFederalID, UnitType, NumUnits)
select pf.projectfederalId, 26222, [Five beds]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull( [Five beds] , 0 ) != 0

select * from VHCB.dbo.federalunit
go


truncate table VHCB.dbo.ProjectFederalIncomeRest
go

insert into VHCB.dbo.ProjectFederalIncomeRest(ProjectFederalID, LkAffordunits, Numunits)
select pf.projectfederalId, 26277, [# 50%]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([# 50%] , 0 ) != 0
go

insert into VHCB.dbo.ProjectFederalIncomeRest(ProjectFederalID, LkAffordunits, Numunits)
select pf.projectfederalId, 26276, [# 60%]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([# 60%] , 0 ) != 0
go

insert into VHCB.dbo.ProjectFederalIncomeRest(ProjectFederalID, LkAffordunits, Numunits)
select pf.projectfederalId, 26278, [# 80%]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([# 80%] , 0 ) != 0
go

insert into VHCB.dbo.ProjectFederalIncomeRest(ProjectFederalID, LkAffordunits, Numunits)
select pf.projectfederalId, 27641, [# 100%]
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where  isnull([# 100%] , 0 ) != 0
go

select * from VHCB.dbo.ProjectFederalIncomeRest
go



truncate table VHCB.dbo.FederalProjectInspection
go

insert into VHCB.dbo.FederalProjectInspection(ProjectFederalID, NextInspect, [InspectDate])
select pf.projectfederalId, 
case [Next Inspection] when 'expired' then null
else
[Next Inspection] end as NextInspect, 
case [Most Recent Inspection ] when '(EXPIRED)' then null
else
CONVERT(datetime, '06/15/' + [Most Recent Inspection ])
 end as InspectDate
from ptALLFedProjects allFed(nolock)
join MasterProj mp(nolock) on mp.Proj_num = allFed.[Project Number]
join VHCb.dbo.projectfederal pf(nolock) on pf.ProjectID = mp.ProjectId
where [Next Inspection] is not null
go


select * from VHCB.dbo.FederalProjectInspection
go