
create procedure dbo.UpdateACMember
(
	@ACMemberID		int, 
	@StartDate		datetime, 
	@EndDate		datetime, 
	@LkSlot			int, 
	@LkServiceType	int, 
	@Tshirt			int, 
	@SweatShirt		int, 
	@DietPref		int, 
	@MedConcerns	nvarchar(350), 
	@Notes			nvarchar(max)
) as
begin 
		update ACMembers set StartDate = @StartDate, EndDate = @EndDate, LkSlot = @LkSlot, LkServiceType = @LkServiceType, Tshirt = @Tshirt, SweatShirt = @SweatShirt, DietPref = @DietPref, MedConcerns = @MedConcerns, Notes = @Notes
		where ACMemberID = @ACMemberID
end