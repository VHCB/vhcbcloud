CREATE procedure dbo.GetProjectApplicantList
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
begin transaction
-- GetProjectApplicantList 6586, 1
	begin try

	select pa.ProjectApplicantID, 
			case isnull(pa.IsApplicant, 0) when 0 then 'No' else 'Yes' end IsApplicant1,
			case isnull(pa.FinLegal, 0) when 0 then 'No' else 'Yes' end FinLegal1,
			isnull(pa.IsApplicant, 0) as IsApplicant, 
			isnull(pa.FinLegal, 0) as FinLegal,
			pa.LkApplicantRole, lv.Description as 'ApplicantRoleDescription',
			pa.RowIsActive,
			a.ApplicantId, a.Individual, a.LkEntityType, a.FYend, a.website, a.Stvendid, a.LkPhoneType, a.Phone, a.email, 
			an.applicantname, a.LKEntityType2,
			--c.LkPrefix, c.Firstname, c.Lastname, c.LkSuffix, c.LkPosition, c.Title, 
			--ac.ApplicantID, ac.ContactID, ac.DfltCont, 
			aan.appnameid, aan.defname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		--left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		--left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @ProjectId
			and (@IsActiveOnly = 0 or pa.RowIsActive = @IsActiveOnly)
		order by pa.DateModified desc
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