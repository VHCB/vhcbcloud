
create procedure dbo.UpdateProjectLeadBldg
(
	@LeadBldgID		int, 
	@Building		int, 
	@AddressID		int, 
	@Age			int, 
	@Type			int, 
	@LHCUnits		int, 
	@FloodHazard	bit, 
	@FloodIns		bit, 
	@VerifiedBy		int, 
	@InsuredBy		varchar(150), 
	@HistStatus		int, 
	@AppendA		int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadBldg set  Building = @Building, AddressID = @AddressID, Age = @Age, Type = @Type, LHCUnits = @LHCUnits, 
		FloodHazard = @FloodHazard, FloodIns = @FloodIns, VerifiedBy = @VerifiedBy, InsuredBy = @InsuredBy, 
		HistStatus = @HistStatus, AppendA = @AppendA, RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectLeadBldg
	where LeadBldgID = @LeadBldgID
	
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