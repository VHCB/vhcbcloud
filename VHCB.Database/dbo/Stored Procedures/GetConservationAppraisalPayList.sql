
create procedure GetConservationAppraisalPayList  
(
	@AppraisalInfoID	int,
	@IsActiveOnly		bit
)
as
begin
--exec GetConservationAppraisalPayList 6625, 1
	select pay.AppraisalPayID, pay.PayAmt, an.applicantname WhoPaid, a.applicantid, --pay.WhoPaid, 
	pay.RowIsActive
	from AppraisalPay pay(nolock)
	join applicantappname aan(nolock) on pay.WhoPaid = aan.ApplicantID
	join appname an(nolock) on aan.appnameid = an.appnameid
	join applicant a(nolock) on a.applicantid = aan.applicantid
	where pay.AppraisalInfoID = @AppraisalInfoID
		and (@IsActiveOnly = 0 or pay.RowIsActive = @IsActiveOnly)
	order by pay.DateModified desc
end