
create procedure GetConservationAppraisalInfoList  
(
	@AppraisalID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetConservationAppraisalInfoList 6625, 1
	select ai.AppraisalInfoID, ai.AppraisalID, ai.LkAppraiser, description as 'Appraiser', ai.AppOrdered, ai.AppRecd, ai.EffDate, ai.AppCost, 
		ai.Comment, ai.NRCSSent, ai.RevApproved, ai.ReviewDate, ai.RowIsActive, ai.DateModified,
		ai.URL,
		CASE when isnull(ai.URL, '') = '' then '' else 'Click here' end as URLText
	from AppraisalInfo ai(nolock)
	left join LookupValues (nolock) on TypeID = ai.LkAppraiser
	where ai.AppraisalID = @AppraisalID
		and (@IsActiveOnly = 0 or ai.RowIsActive = @IsActiveOnly)
	order by ai.DateModified desc
end