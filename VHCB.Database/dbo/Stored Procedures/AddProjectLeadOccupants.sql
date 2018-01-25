
create procedure dbo.AddProjectLeadOccupants
(
	@ProjectID		int, 
	@LeadBldgID		int, 
	@LeadUnitID		int,
	@Name			nvarchar(30), 
	@LKAge			int,
	@LKEthnicity	int,
	@LKRace			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	--if not exists
 --   ( 
	--	select 1 
	--	from ProjectLeadOccupant (nolock)
	--	where LeadBldgID = @LeadBldgID and LeadUnitID = @LeadUnitID
	--)
	--begin
		insert into ProjectLeadOccupant(ProjectID, LeadBldgID, LeadUnitID, Name, LKAge, LKEthnicity, LKRace)
		values(@ProjectID, @LeadBldgID, @LeadUnitID, @Name, @LKAge, @LKEthnicity, @LKRace)

		set @isDuplicate = 0
	--end

	--if(@isDuplicate = 1)
	--begin
	--	select @isActive =  RowIsActive 
	--	from ProjectLeadOccupant (nolock)
	--	where LeadBldgID = @LeadBldgID and LeadUnitID = @LeadUnitID
	--end

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