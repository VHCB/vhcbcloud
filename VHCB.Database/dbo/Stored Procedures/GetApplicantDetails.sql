
create procedure [dbo].GetApplicantDetails
(
	@appnameid int	
)
as 
--exec GetApplicantDetails 417
Begin

	select a.ApplicantId, a.Individual, a.LkEntityType, a.FYend, a.website, a.Stvendid, a.LkPhoneType, a.Phone, a.email, 
			an.applicantname,
			c.LkPrefix, c.Firstname, c.Lastname, c.LkSuffix, c.LkPosition, c.Title, 
			ac.ApplicantID, ac.ContactID, ac.DfltCont, 
			aan.appnameid, aan.defname
		from applicantappname aan(nolock) 
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID 
		where an.appnameid = @appnameid

end