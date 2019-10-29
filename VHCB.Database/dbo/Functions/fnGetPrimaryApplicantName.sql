CREATE function fnGetPrimaryApplicantName
(
      @ProjectId INT 
)
RETURNS varchar(150)
AS 
BEGIN
	DECLARE @PrimaryApplicantName AS varchar(150) ;

	Select  top 1 @PrimaryApplicantName = an.Applicantname
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa(nolock) on pa.ApplicantId = a.ApplicantId
	where pa.ProjectId = @ProjectId and pa.LkApplicantRole = 358 --Primary Applicant

	RETURN  @PrimaryApplicantName ;
End