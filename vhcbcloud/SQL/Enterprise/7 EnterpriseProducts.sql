use vhcb
go

begin tran

truncate table dbo.EnterpriseProducts
go


insert into dbo.EnterpriseProducts(ProjectID, LkProduct, StartDate)
SELECT Project_Id, [ProductOrCrop code], getdate() as StartDate
FROM [FFVConvert].[dbo].[uniqueProjects] up
join dbo.project_v v on v.project_name = up.[project name]

select * from dbo.EnterpriseProducts
go

--2110
--rollback
--commit