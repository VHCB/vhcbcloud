
create procedure dbo.GetProjectApplicant
(
	@ProjectId int
) 
as
begin 
	select pa.ProjectApplicantID, 			
			isnull(pa.IsApplicant, 0) as IsApplicant, 
			isnull(pa.FinLegal, 0) as FinLegal,			
			a.ApplicantId, a.Individual, 
			an.applicantname,			
			aan.appnameid, aan.defname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @ProjectId
			and pa.RowIsActive = 1
		order by pa.IsApplicant desc, pa.FinLegal desc, pa.DateModified desc
	end