
create procedure dbo.ProjectSearch
(
	@ProjNum				nvarchar(24) = null,
	@ProjectName			nvarchar(200) = null,
	@AppName				varchar(150) = null,
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
-- exec ProjectSearch  null, null, '0TBD', 145, null, null, 133, null
-- exec ProjectSearch  '0000-000', null, null, null, null, null, null, null
--select * from projects_v
	begin try
	declare @ProjNum1 varchar(50)
	declare @AppNameID int
	select @ProjNum1 = dbo.GetHyphenProjectNumber(@ProjNum);

	select @AppNameID = appnameid from Appname(nolock) where ApplicantName = @AppName

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