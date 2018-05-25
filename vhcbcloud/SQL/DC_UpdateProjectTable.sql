use PTConvert
go


begin tran

update p1 set p1.LkProjectType = VHCBType, 
p1.LkProgram = case	when p2.conserv = 1 then 145
					when p2.house = 1 then 144
			   end,
p1.Goal = case when isnull(p2.histelem, 0) = '1' then 1 else 0 end
from VHCB.dbo.Project p1(nolock)
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join prtype prt(nolock) on prt.[key] = p2.prtypekey

commit
--rollback

truncate table VHCB.dbo.ProjectEvent
go

insert into VHCB.dbo.ProjectEvent(Prog, ProjectID, EventID, ProgEventID, Date)
select LkProgram, ProjectId, 26664, 26664, GETDATE()
from VHCB.dbo.Project
go

select * from VHCB.dbo.ProjectEvent
go

truncate table VHCB.dbo.Conserve
go

insert into VHCB.dbo.Conserve(ProjectID, LkConsTrack, GeoSignificance, NumEase)
select p1.ProjectId, case when ctrack = 'Agricultural' then 32
		    when ctrack = 'Historical' then 33 
			when ctrack = 'Natural/Non Ag' then 34 
			when ctrack = 'Sugarbush' then 35 
			when ctrack = 'Private Working Froest' then 36 
		end as LkConsTrack,
		case when (clconproj = 1 or clagproj = 1) then 26877 else null end as GeoSignificance,
		ceaseno
from MasterProj p1(nolock)
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where p2.conserv = 1
go

select * from VHCB.dbo.Conserve
go

truncate table VHCB.dbo.ConserveLegMech
go

insert into  VHCB.dbo.ConserveLegMech(ConserveID, LKLegMech)
select c.ConserveID, 128 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where clmease = 1 
go

insert into  VHCB.dbo.ConserveLegMech(ConserveID, LKLegMech)
select c.ConserveID, 129
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where clmagree = 1 
go

insert into  VHCB.dbo.ConserveLegMech(ConserveID, LKLegMech)
select c.ConserveID, 130
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where clmdeed = 1 
go

insert into  VHCB.dbo.ConserveLegMech(ConserveID, LKLegMech)
select c.ConserveID, 131
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where clmother = 1 
go

select * from VHCB.dbo.ConserveLegMech;
go

truncate table VHCB.dbo.ConserveLegInterest
go

insert into  VHCB.dbo.ConserveLegInterest(ConserveID, LKLegInterest)
select c.ConserveID, 405
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where clifee = 1
go

insert into  VHCB.dbo.ConserveLegInterest(ConserveID, LKLegInterest)
select c.ConserveID, 406
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where cliease = 1
go

select * from VHCB.dbo.ConserveLegInterest
go

truncate table VHCB.dbo.ConserveAttrib
go

insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
select c.ConserveID, 24 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where cahistacq = 1 
go

insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
select c.ConserveID, 25 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where cahistrhb = 1 
go

insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
select c.ConserveID, 26 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where caag = 1 
go

insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
select c.ConserveID, 27 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where capubacc = 1 
go

insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
select c.ConserveID, 28 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where caarch = 1 
go

select * from VHCB.dbo.ConserveAttrib order by ConserveId
go

--truncate table VHCB.dbo.ConserveAttribProj
--go

--insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
--select c.ConserveID, 29 
--from VHCB.dbo.Conserve c(nolock)
--join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
--join ptproj p2(nolock) on p2.[number] = p1.Proj_num
--where canat = 1 
--go

--insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
--select c.ConserveID, 30 
--from VHCB.dbo.Conserve c(nolock)
--join VHCB.dbo.Project p1(nolock) on c.ProjectID = p1.ProjectId
--join ptproj p2(nolock) on p2.[number] = p1.Proj_num
--where cawater = 1 
--go

--insert into  VHCB.dbo.ConserveAttrib(ConserveID, LkConsAttrib)
--select c.ConserveID, 31 
--from VHCB.dbo.Conserve c(nolock)
--join VHCB.dbo.Project p1(nolock) on c.ProjectID = p1.ProjectId
--join ptproj p2(nolock) on p2.[number] = p1.Proj_num
--where caeco = 1 
--go



truncate table VHCB.dbo.ConserveAffMech;
go

insert into  VHCB.dbo.ConserveAffMech(ConserveID, LkConsAffMech)
select c.ConserveID, 227 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where caffagop = 1 
go

insert into  VHCB.dbo.ConserveAffMech(ConserveID, LkConsAffMech)
select c.ConserveID, 226
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
where caffshap = 1 
go

select * from VHCB.dbo.ConserveAffMech;
go

truncate table VHCB.dbo.AppraisalValue;
go

insert into  VHCB.dbo.AppraisalValue(ProjectID, Apbef, Apaft, Aplandopt)
select p1.ProjectId, pc.capbef, pc.capaft, pc.capopt
from MasterProj p1(nolock) 
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
go

select * from VHCB.dbo.AppraisalValue;
go

truncate table VHCB.dbo.ConserveAcres;
go


insert into VHCB.dbo.ConserveAcres(ConserveID, LkAcres, Acres)
select c.ConserveID, 267, cvhist 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where cvhist <> 0 
go

insert into VHCB.dbo.ConserveAcres(ConserveID, LkAcres, Acres)
select c.ConserveID, 268, cdag 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where cdag <> 0 
go

insert into VHCB.dbo.ConserveAcres(ConserveID, LkAcres, Acres)
select c.ConserveID, 269, cdrec 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where cdrec <> 0 
go

insert into VHCB.dbo.ConserveAcres(ConserveID, LkAcres, Acres)
select c.ConserveID, 270, cdhist 
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where cdhist <> 0 
go

update VHCB.dbo.ConserveAcres set Acres = Acres + isnull(clag, 0)
--select c.ConserveID, acres + cdag
from VHCB.dbo.ConserveAcres ca(nolock) 
join VHCB.dbo.Conserve c(nolock) on ca.ConserveID = c.ConserveID
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where ca.LkAcres = 268
go

update VHCB.dbo.ConserveAcres set Acres = Acres + isnull(clrec, 0)
--select c.ConserveID, acres + cdrec
from VHCB.dbo.ConserveAcres ca(nolock) 
join VHCB.dbo.Conserve c(nolock) on ca.ConserveID = c.ConserveID
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where ca.LkAcres = 269
go

update VHCB.dbo.ConserveAcres set Acres = Acres + isnull(clhist, 0)
--select c.ConserveID, acres + clhist
from VHCB.dbo.ConserveAcres ca(nolock) 
join VHCB.dbo.Conserve c(nolock) on ca.ConserveID = c.ConserveID
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where ca.LkAcres = 270
go

select * from VHCB.dbo.ConserveAcres 
go

update c set Tillable = pc.cvagtill, Pasture = pc.cvagpas, Wooded = pc.cvagwd, 
	Unmanaged = pc.cvagoth, Naturalrec = pc.cvrec, Statewide = pc.cstwide, Prime = pc.cprime
--select c.ConserveID,*, pc.cvagtill, pc.cvagpas, pc.cvagwd, pc.cvagoth, pc.cvrec
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
where p2.conserv = 1
go

select * from VHCB.dbo.Conserve
go

select c.ConserveID, 26083 LKBudgetPeriod, con.csvhcb
from VHCB.dbo.Conserve c(nolock)
join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
join ptproj p2(nolock) on p2.[number] = p1.Proj_num
join ptapplctn ap(nolock) on ap.projkey = p1.[key]
join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
join ptconssu con(nolock) on con.projkey = p2.[key]
where p2.conserv = 1
go

select * from VHCB.dbo.ConserveSU
select * from VHCB.dbo.ConserveSources




select * from ptconsacres



select * from [dbo].[ptconssu]