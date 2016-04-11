use vhcbsandbox
go

alter view projects_v as
	select p.ProjectId, Proj_num, lv.Description as ProjectName, LKProjectType, LKProgram, lv1.Description as programname,  a.Street# + ' ' + a.Address1 
	+ ' ' + a.Address2  as Address, a.Town + ', ' + a.state + ' ' + a.Zip as AddressTownStateZip, a.County, a.Town, 
	an.AppNameID, an.Applicantname--, * 
	from Project p(nolock)
	join projectName pn(nolock) on p.projectid = pn.projectid
	left join lookupvalues lv(nolock) on lv.Typeid = pn.LKProjectname
	left join ProjectAddress pa(nolock) on pa.projectId = p.projectId and pa.PrimaryAdd = 1
	left join Address a(nolock) on a.addressid = pa.addressid
	left join ProjectApplicant pap(nolock) on pap.projectid = p.projectid
	left join applicantappname aan(nolock) on aan.ApplicantID = pap.applicantid
	left join appname an(nolock) on an.AppNameID = aan.AppNameID
	left join lookupvalues lv1(nolock) on lv1.TypeID = p.LkProgram
	where pn.Defname = 1 and pa.RowIsActive = 1 --and pap.Defapp = 1
	--and Proj_num = '0000-000-000' 
go
--select * from projectaddress
--select * from lookupvalues where typeid = 133
--select DefApp, * from ProjectApplicant
--select * from ApplicantAppName
--select * from appname

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectTowns]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectTowns
go

create procedure dbo.GetProjectTowns
as
begin transaction

	begin try
	
		select distinct Town from address a(nolock)
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where isnull(a.Town, '') != '' 
		order by Town

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
		RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetCounties]') and type in (N'P', N'PC'))
drop procedure [dbo].GetCounties
go

create procedure dbo.GetCounties
as
begin transaction

	begin try
	
		select distinct county from CountyTown
		order by county

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
		RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

