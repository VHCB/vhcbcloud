
create procedure GetApplicantApplicantList
(
	@ApplicantId	int,
	@IsActiveOnly	bit
)  
as
--exec GetApplicantApplicantList 1, 1
begin
	select aa.ApplicantApplicantId, aa.AttachedApplicantId, an.Applicantname as AttachedApplicantName, aa.RowIsActive 
	from ApplicantApplicant aa(nolock)
	join ApplicantAppName aaname(nolock) on aaname.ApplicantID = aa.AttachedApplicantId
	join AppName an(nolock) on an.AppNameID = aaname.AppNameID
	where aa.ApplicantId = @ApplicantId
	and (@IsActiveOnly = 0 or aa.RowIsActive = @IsActiveOnly)
		order by aa.DateModified desc
end