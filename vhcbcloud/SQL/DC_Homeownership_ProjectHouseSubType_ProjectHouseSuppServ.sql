use PTConvert
go
--ProjectHouseAccessAdapt
--ProjectHouseConsReuseRehab
--Homeownership
--ProjectHouseSubType
--ProjectHouseSuppServ
--ProjectHouseAgeRestrict
--ProjectHouseVHCBAfford

truncate table VHCB.dbo.ProjectHouseAccessAdapt
go

insert into VHCB.dbo.ProjectHouseAccessAdapt(HousingID, LkUnitChar, Numunits)
select h.HousingID, 549, haccess
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where haccess <> 0
go

select * from VHCB.dbo.ProjectHouseAccessAdapt
go

truncate table VHCB.dbo.ProjectHouseConsReuseRehab
go

insert into VHCB.dbo.ProjectHouseConsReuseRehab(HousingID, LkUnitChar, Numunits)
select h.HousingID, 26111, hntm
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hntm <> 0
go

select * from VHCB.dbo.ProjectHouseConsReuseRehab
go

truncate table VHCB.dbo.Homeownership
go

insert into VHCB.dbo.Homeownership(ProjectId, MH, Condo, SFD, [AddressID])
select h.ProjectId, hosfmh, hosfc, isnull(hoc, 0) + isnull(hosfd, 0), a.AddressId
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
left join VHCB.dbo.projectaddress a(nolock) on a.ProjectID = h.ProjectID
go

delete from 
VHCB.dbo.Homeownership
where MH = 0 and Condo = 0 and SFD  = 0

select * from VHCB.dbo.Homeownership
go

update h set h.LkHouseCat  = 42 
from VHCB.dbo.Housing h
join VHCB.dbo.Homeownership how(nolock) on h.ProjectID = how.ProjectId
where  MH = 1 or Condo = 1 or SFD  = 1
go

select * from  VHCB.dbo.Housing where LkHouseCat  = 42 
--854
select * from  VHCB.dbo.Housing where LkHouseCat  = 43
--854
go

update h set h.LkHouseCat  = 43 
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where isnull(hrmh , 0) + isnull(hrmulti, 0) +
	isnull(hrgh, 0) + isnull(hrlc, 0) +
	isnull(hrsro, 0) + isnull(hrassist, 0) +
	isnull(hrshelt, 0) + isnull(hoth, 0) > 0
go

truncate table VHCB.dbo.ProjectHouseSubType
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 26307, hosfd
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hosfd <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 26308, hosfc
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hosfc <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 163, hosfmh
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hosfmh <> 0
go


insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 163, hrmh
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrmh <> 0
go


insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 165, hrmulti
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrmulti <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 165, hrlc
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrlc <> 0
go

insert into vhcb.dbo.ProjectVHCBPriorities(ProjectID, LkVHCBPriorities)
select h.ProjectID, 27444
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrlc <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 166, hrgh
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrgh <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 168, hrshelt
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hrshelt <> 0
go

insert into VHCB.dbo.ProjectHouseSubType(HousingID, LkHouseType, Units)
select h.HousingID, 170, hoth
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hoth <> 0
go

select * from VHCb.dbo.ProjectHouseSubType
go

truncate table VHCB.dbo.ProjectHouseSuppServ
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 171, hspaids
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspaids <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 172, hspcorr
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspcorr <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 180, hspdd
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspdd <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 173, hspdv
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspdv <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 181, hspeld
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspeld <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 174, hsph
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hsph <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 175, hspphyd
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspphyd <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 176, hsppsyd
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hsppsyd <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 26308, hsptr
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hsptr <> 0
go

insert into VHCB.dbo.ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits)
select h.HousingID, 177, hspsub
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where hspsub <> 0
go

select * from VHCb.dbo.ProjectHouseSuppServ
go


truncate table vhcb.dbo.ProjectHouseAgeRestrict
go

insert into VHCB.dbo.ProjectHouseAgeRestrict(HousingID, LKAgeRestrict, Numunits)
select h.HousingID, 26373, held
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where held <> 0
go

select * from vhcb.dbo.ProjectHouseAgeRestrict
go

truncate table vhcb.dbo.ProjectHouseVHCBAfford
go

--insert into VHCB.dbo.ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
--select h.HousingID, 00, acov30
--from pthousingua ptHouse(nolock)
--join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
--join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
--join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
--where acov30 <> 0
--go

insert into VHCB.dbo.ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
select h.HousingID, 183, acov50
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where acov50 <> 0
go

insert into VHCB.dbo.ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
select h.HousingID, 185, acov60
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where acov60 <> 0
go

insert into VHCB.dbo.ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
select h.HousingID, 185, acov80
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where acov80 <> 0
go

insert into VHCB.dbo.ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
select h.HousingID, 186, acov100
from pthousingua ptHouse(nolock)
join ptapplctn ap(nolock) on ap.[key] = ptHouse.applctnkey
join MasterProj mp(nolock) on ap.[projkey] = mp.[key]
join  VHCB.dbo.Housing h(nolock) on mp.[ProjectId] = h.[ProjectID]
where acov100 <> 0
go

select * from vhcb.dbo.ProjectHouseVHCBAfford
go
