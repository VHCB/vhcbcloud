Use FFV
go

insert into VHCB.dbo.EnterpriseAcres(ProjectID, AcresInProduction, AcresOwned, AcresLeased)
select p.projectid, [AcresInProduction], [AcresOwned], [AcresLeased]
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num


update VHCB.dbo.EnterpriseAcres set TotalAcres = isnull(AcresInProduction, 0) + isnull(AcresOwned, 0) + isnull(AcresLeased, 0)
go

select * from VHCB.dbo.EnterpriseAcres
go

insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26236, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.Organic = 1

insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26237, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.Conserved = 1
	
insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26238, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.Transfer = 1

insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26239, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.onFarmProc = 1

insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26448, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.LCB = 1

insert into VHCB.dbo.enterpriseAttributes(ProjectID, LKAttributeID, Date)
select p.projectid, 26677, CONVERT(varchar, getdate(), 101)
from [dbo].[Viability Conversion #2] v2
join VHCB.dbo.Project p on v2.[Project #] = p.proj_num
where v2.outOFBiz = 1



select * from VHCB.dbo.enterpriseAttributes
go