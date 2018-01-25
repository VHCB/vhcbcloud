
create procedure dbo.AddACMember
(
	@ApplicantID	int, 
	@ContactID		int,
	@StartDate		datetime, 
	@EndDate		datetime, 
	@LkSlot			int, 
	@LkServiceType	int, 
	@Tshirt			int, 
	@SweatShirt		int, 
	@DietPref		int, 
	@MedConcerns	nvarchar(350), 
	@Notes			nvarchar(max), 
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ACMembers(nolock)
		where ApplicantID = @ApplicantID 
    )
	begin
		insert into ACMembers(ApplicantID, ContactID, StartDate, EndDate, LkSlot, LkServiceType, Tshirt, SweatShirt, DietPref, MedConcerns, Notes)
		values(@ApplicantID, @ContactID, @StartDate, @EndDate, @LkSlot, @LkServiceType, @Tshirt, @SweatShirt, @DietPref, @MedConcerns, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ACMembers(nolock)
		where ApplicantID = @ApplicantID 
	end

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
        RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;