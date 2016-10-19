use vhcbsandbox
go

alter view projects_v as
	select p.ProjectId, Proj_num, lv.Description as ProjectName, LKProjectType, LKProgram, lv1.Description as programname,  a.Street# + ' ' + a.Address1 
	+ ' ' + a.Address2  as Address, a.Town + ' ' + a.village + ' ' +a.county + ' ' + a.Zip as FullAddress, a.County, a.Town, 
	an.AppNameID, an.Applicantname, pap.LkApplicantRole, isnull(pa.PrimaryAdd, 0) PrimaryAdd, 
	isnull(pn.Defname, 0) IsProjectDefName--,  * 
	from Project p(nolock)
	left join projectName pn(nolock) on p.projectid = pn.projectid --and pn.Defname = 1
	left join lookupvalues lv(nolock) on lv.Typeid = pn.LKProjectname
	left join ProjectAddress pa(nolock) on pa.projectId = p.projectId --and pa.PrimaryAdd = 1
	left join Address a(nolock) on a.addressid = pa.addressid
	left join ProjectApplicant pap(nolock) on pap.projectid = p.projectid
	left join applicantappname aan(nolock) on aan.ApplicantID = pap.applicantid
	left join appname an(nolock) on an.AppNameID = aan.AppNameID
	left join lookupvalues lv1(nolock) on lv1.TypeID = p.LkProgram
	--where pn.Defname = 1 and pa.RowIsActive = 1 --and pap.Defapp = 1
	--where Proj_num = '9999-999-991'
go
--select * from ProjectApplicant
--select * from projects_v
--select * from lookupvalues where typeid = 133
--select DefApp, * from ProjectApplicant
--select * from projectName where projectid = 6583
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

		select distinct county 
		from address a(nolock)
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where isnull(a.county, '') != '' 
		order by county

		--select distinct county from CountyTown
		--order by county

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[ProjectSearch]') and type in (N'P', N'PC'))
drop procedure [dbo].ProjectSearch
go

create procedure dbo.ProjectSearch
(
	@ProjNum				nvarchar(24) = null,
	@ProjectName			nvarchar(200) = null,
	@AppNameID				int = null,
	@LKProgram				int = null,
	@Town					nvarchar(100) = null,
	@County					nvarchar(40) = null,
	@LKProjectType			int = null,
	@IsPrimaryApplicant		bit = null
)
as
begin transaction
-- exec ProjectSearch  null, 'po up', null, 145, 'Fremont', null, null
-- exec ProjectSearch  null, null, null, 145, null, 'Windsor ', null, null
-- exec ProjectSearch  null, null, null, 145, null, null, 133, null
-- exec ProjectSearch  null, null, 1015, 145, null, null, 133, null
-- exec ProjectSearch  '0000-000', null, null, null, null, null, null, null
--select * from projects_v
	begin try
	declare @ProjNum1 varchar(50)
	select @ProjNum1 = dbo.GetHyphenProjectNumber(@ProjNum);

	if(isnull(@IsPrimaryApplicant, 0) = 0)
	begin
		select distinct ProjectId, Proj_num, ProjectName, LKProjectType, LKProgram, programname,  Address, FullAddress, County, Town, 
			AppNameID, Applicantname 
		from projects_v
		where  (@ProjNum is null or Proj_num like '%'+ @ProjNum1 + '%')
			and (@ProjectName is null or ProjectName like '%'+ @ProjectName + '%')
			and (@AppNameID is null or AppNameID = @AppNameID)
			and (@LKProgram is null or LKProgram = @LKProgram)
			and (@Town is null or Town = @Town)
			and (@County is null or County = @County)
			and (@LKProjectType is null or LKProjectType = @LKProjectType)
			and (isnull(@IsPrimaryApplicant, 0) = 0 or LkApplicantRole = 358)
		order by Proj_num
	end
	else
	begin
		select distinct ProjectId, Proj_num, ProjectName, LKProjectType, LKProgram, programname,  Address, FullAddress, County, Town, 
			AppNameID, Applicantname
		from projects_v
		where  (@ProjNum is null or Proj_num like '%'+ @ProjNum1 + '%')
			and (@ProjectName is null or ProjectName like '%'+ @ProjectName + '%')
			and (@AppNameID is null or AppNameID = @AppNameID)
			and (@LKProgram is null or LKProgram = @LKProgram)
			and (@Town is null or Town = @Town)
			and (@County is null or County = @County)
			and (@LKProjectType is null or LKProjectType = @LKProjectType)
			and (isnull(@IsPrimaryApplicant, 0) = 0 or LkApplicantRole = 358)
			and IsProjectDefName = 1
			and PrimaryAdd = 1
		order by Proj_num
	end
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetPrimaryApplicants]') and type in (N'P', N'PC'))
drop procedure [dbo].GetPrimaryApplicants
go

create procedure dbo.GetPrimaryApplicants
as
begin transaction
	begin try
	
		select distinct an.appnameid, an.ApplicantName
		from Appname an
		join ApplicantAppName aan on aan.appnameid = an.appnameid
		join ProjectApplicant pa(nolock) on aan.ApplicantID = pa.ApplicantId
		where pa.LkApplicantRole = 358
			and pa.RowIsActive = 1
			and aan.DefName = 1
		order by an.ApplicantName asc
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

--select dbo.GetHyphenProjectNumber('2222-2222-23')
CREATE FUNCTION dbo.GetHyphenProjectNumber 
(
	@Original_Project_Num VARCHAR(50)
)
RETURNS VARCHAR(50)
AS BEGIN
Declare @Project_Num varchar(50)
set @Project_Num = replace(@Original_Project_Num, '-', '')-- '1222222221'
Declare @FinalNum varchar(50)

if(len(@Project_Num) > 4)
begin
	--print 'Here1'
	--set @FinalNum = STUFF(STUFF(@Project_Num, LEN(@Project_Num)-  2, 0,'-'), LEN(@Project_Num) + 1, 0,'-')
	set @FinalNum = STUFF(@Project_Num, 5, 0,'-')
	if(len(@Project_Num) > 7)
	begin
		--print 'Here2'
		set @FinalNum = STUFF(@FinalNum, 9, 0,'-')
	end
end
else
begin
	--print 'Here'
	set @FinalNum = @Project_Num
end
return  @FinalNum
end
go