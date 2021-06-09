use vhcb
go


truncate table EnterprisePrimeProduct
go

insert into EnterprisePrimeProduct(ProjectID, OtherNames, PrimaryProduct, YrManageBus)
select Projectid, OtherNames, PrimaryProduct,  CONVERT (VARCHAR(50), YrManageBus, 50)  from AdditionalProjectFarmerDups_v
where PrimaryProduct is not null

select * from EnterprisePrimeProduct
go

--dbo.EnterpriseAttributes

truncate table dbo.EnterpriseAttributes
go

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26236, getdate() from AdditionalProjectFarmerDups_v where Organic != 0

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26237, getdate() from AdditionalProjectFarmerDups_v where Conserved != 0

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26238, getdate() from AdditionalProjectFarmerDups_v where Transfer != 0

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26239, getdate() from AdditionalProjectFarmerDups_v where OnFarmProc != 0

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26448, getdate() from AdditionalProjectFarmerDups_v where LCB != 0

insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
select Projectid, 26677, getdate() from AdditionalProjectFarmerDups_v where OutOFBiz != 0




select * from dbo.EnterpriseAttributes
go

--dbo.EnterpriseAcres
truncate table dbo.EnterpriseAcres
go


insert into EnterpriseAcres(ProjectID, AcresInProduction, AcresOwned, AcresLeased, AccessAcres)
select ProjectID, [AcresInProduction], AcresOwned,[AcresLeased], isnull([Acres from Access], 0) from  AdditionalProjectFarmerDups_v
go

--update [Final_Viab_Conversion] set [Acres from Access] = 0   
--  FROM [dbo].[Final_Viab_Conversion] where [Acres from Access]  = 'NULL'
select * from dbo.EnterpriseAcres
go


truncate table EnterpriseProducts
go

insert into EnterpriseProducts( ProjectID, LkProduct, StartDate, RowIsActive)
select p.ProjectId, fp.Prod_code as LKProduct, getdate() as StartDate, 1 from 
project p(nolock)
--join FFvConvert.dbo.FarmProducts fp(nolock) on p.Proj_num = fp.Project
join FFvConvert.dbo.FixedFarmProducts fp(nolock) on p.Proj_num = fp.Project
go


select * from EnterpriseProducts

select * from FFvConvert.dbo.FarmProducts
select * from FFvConvert.dbo.FixedFarmProducts

select Project, Prod_code, count(*) from FFvConvert.dbo.FarmProducts
group by Project, Prod_code
having count(*) >  1