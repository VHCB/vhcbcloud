use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[getprojectslist]') and type in (N'P', N'PC'))
drop procedure [dbo].getprojectslist
go

create procedure getprojectslist
as
begin

	select p.projectid, proj_num, rtrim(ltrim(lpn.description)) description,  convert(varchar(25), p.projectid) +'|' + rtrim(ltrim(lpn.description)) as project_id_name
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	where defname = 1
	order by proj_num
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[get_managers]') and type in (N'P', N'PC'))
drop procedure [dbo].get_managers
go

create procedure dbo.get_managers
as	
begin
-- dbo.get_managers
	set nocount on   
	  
	select UserId, ltrim(rtrim(Lname)) + ', ' + ltrim(rtrim(Fname)) Name from userinfo
	order by Lname

	if (@@error <> 0)    
    begin  
        raiserror ( 'get_managers' , 0 ,1)  
        return 1  
    end  
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[get_boardDates]') and type in (N'P', N'PC'))
drop procedure [dbo].get_boardDates
go

create procedure dbo.get_boardDates
as	
begin
-- dbo.get_boardDates
	set nocount on   
	  
	select TypeID, convert(varchar(10), BoardDate) + ' ' + MeetingType as MeetingType
	from [dbo].[LkBoardDate]
	order by BoardDate

	if (@@error <> 0)    
    begin  
        raiserror ( 'get_managers' , 0 ,1)  
        return 1  
    end  
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[add_new_project]') and type in (N'P', N'PC'))
drop procedure [dbo].add_new_project
go

create procedure dbo.add_new_project
(
	@projNum			nvarchar(12),
	@LkProjectType		int,
	@LkProgram			int,
	@AppRec				Datetime,
	@LkAppStatus		int,
	@Manager			int,
	@LkBoardDate		int,
	@ClosingDate		datetime,
	@GrantClosingDate	datetime,
	@verified			bit,

	@appNameId			int,
	@projName			varchar(75),

	@isDuplicate		bit output
) as
begin transaction

	begin try

	set @isDuplicate = 1

	 if not exists
        (
			select 1
			from project
			where proj_num = @projnum
        )
		begin

			Declare @nameId as int;
			Declare @projectId as int;
			declare @recordId int
			declare @applicantId int

			select  @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
			insert into LookupValues(LookupType, Description)
			values (@recordId, @projName)

			set @nameId = @@IDENTITY

			insert into Project (Proj_num, LkProjectType, LkProgram, AppRec, LkAppStatus, Manager, LkBoardDate, ClosingDate, ExpireDate, verified,  userid)
			values (@projNum, @LkProjectType, @LkProgram, @AppRec, @LkAppStatus, @Manager, @LkBoardDate, @ClosingDate, @GrantClosingDate, @verified,  123)
	
			set @projectId = @@IDENTITY

			insert into ProjectName (ProjectID, LkProjectname, DefName)
			values (@projectId, @nameId, 1)


			Select @applicantId = a.ApplicantId 
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.AppNameID = @appNameId

			insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole)
			values (@projectId, @applicantId, 358)

			set @isDuplicate = 0
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectInfo
go

create procedure dbo.UpdateProjectInfo
(
	@ProjectId			int,
	@LkProjectType		int,
	@LkProgram			int,
	@AppRec				Datetime,
	@LkAppStatus		int,
	@Manager			int,
	@LkBoardDate		int,
	@ClosingDate		datetime,
	@GrantClosingDate	datetime,
	@verified			bit,

	@appNameId			int
	--@projName			varchar(75)
) as
begin transaction

	begin try

	declare @applicantId int

	update Project set LkProjectType = @LkProjectType, LkProgram = @LkProgram, AppRec = @AppRec, LkAppStatus = @LkAppStatus,
		Manager = @Manager, LkBoardDate = @LkBoardDate, ClosingDate = @ClosingDate, ExpireDate = @GrantClosingDate, verified = @verified
	from Project
	where ProjectId = @ProjectId

	Select @applicantId = a.ApplicantId 
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	where an.AppNameID = @appNameId

	update pa set ApplicantId = @applicantId
	from ProjectApplicant pa
	where projectId = @projectId

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[getProjectDetails]') and type in (N'P', N'PC'))
drop procedure [dbo].getProjectDetails
go

create procedure dbo.getProjectDetails
(
	@ProjectId int
) as
--getProjectDetails 6583
begin transaction

	begin try
	declare @AppNameID int
	declare @projectName varchar(75)

	Select @AppNameID =  an.AppNameID 
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa(nolock) on pa.ApplicantId = a.ApplicantId
	where pa.ProjectId = @ProjectId

	select @projectName = rtrim(ltrim(lpn.description))
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	where p.ProjectId = @ProjectId and pn.DefName = 1

	select p.Proj_num, @projectName as projectName, p.LkProjectType, p.LkProgram,p.AppRec, p.LkAppStatus, p.Manager, p.LkBoardDate, p.ClosingDate, p.ExpireDate, p.verified,  p.userid, 
		@AppNameID as AppNameId
	from project p(nolock) 
	left join projectname pn(nolock) on p.projectid = pn.projectid
	where pn.defname = 1 and p.ProjectId = @ProjectId

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectName]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectName
go

create procedure dbo.AddProjectName
(
	@ProjectId	int,
	@projName	varchar(75),
	@DefName	bit
) as
begin transaction

	begin try
	declare @recordId int
	declare @nameId as int
	declare @ProjectNameID int

	select  @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
	insert into LookupValues(LookupType, Description)
	values (@recordId, @projName)

	set @nameId = @@IDENTITY

	insert into ProjectName (ProjectID, LkProjectname, DefName)
	values (@ProjectId, @nameId, @DefName)

	set @ProjectNameID = @@IDENTITY

	if(@DefName = 1)
	begin
	 update ProjectName set DefName = 0 where ProjectId = @ProjectId and ProjectNameID != @ProjectNameID
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


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectNames]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectNames
go

create procedure dbo.GetProjectNames
(
	@ProjectId	int
) as
--GetProjectNames 6583
begin transaction

	begin try

	select TypeID, Description, pn.DefName
	from LookupValues lv(nolock)
	join ProjectName pn(nolock) on lv.TypeID = pn.LkProjectname
	where pn.ProjectID = @ProjectId
	order by DefName desc
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectName]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectName
go

create procedure dbo.UpdateProjectName
(
	@ProjectId		int,
	@TypeId			int,
	@ProjectName	varchar(70),
	@DefName		bit
) as
begin transaction

	begin try

	update lookupvalues set description = @projectName
	where TypeId = @TypeId

	if(@DefName = 1)
	begin
	 update ProjectName set DefName = 0 where ProjectId = @ProjectId
	end

	update ProjectName set DefName = @DefName
	where LKProjectName = @TypeId and ProjectId = @ProjectId
		
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
