
create procedure dbo.UpdateProjectFederal
(
	@ProjectFederalID	int,
	@NumUnits			int,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectFederal set NumUnits = @NumUnits,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectFederal
	where ProjectFederalID = @ProjectFederalID
	
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