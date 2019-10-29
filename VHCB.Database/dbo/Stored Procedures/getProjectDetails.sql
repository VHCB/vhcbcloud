CREATE procedure dbo.getProjectDetails
(
	@ProjectId int
) as
--getProjectDetails 6583
begin transaction

	begin try
	declare @AppNameID int
	declare @AppName varchar(150)
	declare @projectName varchar(75)

	Select @AppNameID =  an.AppNameID, @AppName = an.Applicantname
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa(nolock) on pa.ApplicantId = a.ApplicantId
	where pa.ProjectId = @ProjectId and pa.LkApplicantRole = 358 --Primary Applicant

	select @projectName = rtrim(ltrim(lpn.description))
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	where p.ProjectId = @ProjectId and pn.DefName = 1

	select p.Proj_num, @projectName as projectName, p.LkProjectType, p.LkProgram, lv.Description as program,
		p.AppRec, p.LkAppStatus, p.Manager, p.LkBoardDate, p.ClosingDate, p.ExpireDate, p.verified,  p.userid, 
		@AppNameID as AppNameId, @AppName AppName, Goal, p.verified, CONVERT(VARCHAR(10), p.VerifiedDate, 101) as VerifiedDate
	from project p(nolock) 
	left join projectname pn(nolock) on p.projectid = pn.projectid
	left join LookupValues lv(nolock) on lv.TypeID = p.LkProgram 
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