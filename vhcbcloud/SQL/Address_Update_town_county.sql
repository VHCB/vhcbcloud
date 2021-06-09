
select * from VHCb.dbo.project
--7214
select * from [dbo].[MasterProj]

select nt.town, nt.county, a.Town, a.County

update a set a.Town = nt.town, a.County = nt.county
from VHCb.dbo.Address a(nolock)
join VHCb.dbo.Projectaddress pa(nolock) on pa.AddressId = a.AddressId
--join VHCb.dbo.project p(nolock) on p.ProjectId = pa.ProjectId
join MasterProj  p(nolock) on p.ProjectId = pa.ProjectId
join [dbo].[New towns for import] nt(nolock) on nt.number = p.Proj_num
where pa.PrimaryAdd = 1

