
create procedure dbo.UpdateProjectLeadOccupants
(
	@LeadOccupantID	int,
	@Name			nvarchar(30), 
	@LKAge			int,
	@LKEthnicity	int,
	@LKRace			int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadOccupant set Name = @Name, LKAge = @LKAge, LKEthnicity = @LKEthnicity, LKRace = @LKRace, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectLeadOccupant
	where LeadOccupantID = @LeadOccupantID

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