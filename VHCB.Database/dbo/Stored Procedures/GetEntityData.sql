CREATE procedure [dbo].[GetEntityData]
(
	@ApplicantId		int
)
as
begin
--exec GetEntityData 1076
	declare @LKEntityType2 int

	select @LKEntityType2 = LKEntityType2
	from applicant a(nolock) 
	where  a.ApplicantId = @ApplicantId

	select a.LkEntityType, a.LKEntityType2, a.Individual, a.FYend, a.website, a.email, a.HomePhone, a.WorkPhone, a.CellPhone, a.Stvendid, a.AppRole,
		c.Firstname, c.Lastname, c.LkPosition, c.Title,
		an.Applicantname,
		f.ApplicantID, f.FarmId, f.FarmName, f.LkFVEnterpriseType, f.AcresInProduction, f.AcresOwned, f.AcresLeased, f.AcresLeasedOut, f.TotalAcres, f.OutOFBiz, 
			f.Notes, f.AgEd, f.YearsManagingFarm, isnull(an.AppNameID, '') AppNameID
	from applicant a(nolock) 
	left join applicantcontact ac(nolock) on ac.ApplicantID = a.ApplicantID
	left join contact c(nolock) on c.ContactId = ac.ContactID
	left join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
	left join appname an(nolock) on an.AppNameID = aan.AppNameID
	left join farm f(nolock) on f.ApplicantID = a.ApplicantId
	where  a.ApplicantId = @ApplicantId

end