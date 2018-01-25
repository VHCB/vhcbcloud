CREATE procedure GetConservationAppraisalInfoById
(
	@AppraisalInfoID int
)  
as
--exec GetConservationAppraisalInfoById 6588
begin

	select AppraisalID, LkAppraiser, AppOrdered, AppRecd, EffDate, convert(varchar(10), AppCost) AppCost , Comment, NRCSSent, RevApproved, ReviewDate, RowIsActive, DateModified, URL
	from AppraisalInfo (nolock)
	where AppraisalInfoID = @AppraisalInfoID
end