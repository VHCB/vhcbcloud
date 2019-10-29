
create procedure dbo.GetACMember
(
	@ApplicantID	int
) as
begin
-- exec GetACMember 1119
	select ACMemberID, ApplicantID, ContactID, convert(varchar(10), StartDate, 101)StartDate,   convert(varchar(10), EndDate, 101) EndDate, LkSlot, LkServiceType, Tshirt, SweatShirt, DietPref, MedConcerns, Notes
	from ACMembers where ApplicantID = @ApplicantID
end