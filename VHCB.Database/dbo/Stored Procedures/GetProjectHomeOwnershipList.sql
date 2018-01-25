
create procedure GetProjectHomeOwnershipList  
(
	@HomeOwnershipID	int,
	@IsActiveOnly		bit
)
as
begin
--exec GetProjectHomeOwnershipList 1, 1
	select pho.ProjectHomeOwnershipID, pho.HomeOwnershipID, pho.Owner, dbo.GetApplicantName(pho.Owner) OwnerName, 
		pho.LkLender, dbo.GetApplicantName(pho.LkLender) as LenderName,
		pho.vhfa, pho.RDLoan, pho.VHCBGrant, pho.OwnerApprec, pho.CapImprove, pho.InitFee, pho.ResaleFee, pho.StewFee, pho.AssistLoan, pho.RehabLoan, 
		pho.RowIsActive, pho.DateModified
	from ProjectHomeOwnership pho(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pho.Owner 
	left join LookupValues lv1(nolock) on lv1.TypeID = pho.LkLender 
	where pho.HomeOwnershipID = @HomeOwnershipID
		and (@IsActiveOnly = 0 or pho.RowIsActive = @IsActiveOnly)
	order by pho.DateModified desc
end