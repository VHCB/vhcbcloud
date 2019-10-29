CREATE procedure dbo.GetEntitiesByRole
(
	@LKEntityType2	int,
	@Operation		int
)
as
begin
--exec GetEntitiesByRole 26242
	if(@Operation != 3) --3 is farm
	begin
		select a.ApplicantId, an.ApplicantName + ' ' + convert(varchar(10), isnull(an.AppNameID, ''))  as ApplicantName
		from Appname an(nolock)
		join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.ApplicantID
		where LKEntityType2 = @LKEntityType2
		order by an.Applicantname asc 
	end
	else
	begin
		select a.ApplicantId, f.FarmName as ApplicantName
		from Farm f(nolock)
		join Applicant a(nolock) on a.ApplicantId = f.ApplicantID
	end
end