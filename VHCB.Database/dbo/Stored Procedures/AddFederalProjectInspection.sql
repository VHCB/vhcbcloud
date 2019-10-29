
create procedure dbo.AddFederalProjectInspection
(
	
	@ProjectFederalID		int, 
	@InspectDate			datetime, 
	@NextInspect			nchar(4), 
	@InspectStaff			int, 
	@InspectLetter			datetime, 
	@RespDate				datetime, 
	@Deficiency				bit, 
	@InspectDeadline		datetime
	--@isDuplicate		bit output,
	--@isActive			bit Output
) as
begin transaction

	begin try

		insert into FederalProjectInspection(ProjectFederalID, InspectDate, NextInspect, InspectStaff, InspectLetter, 
			RespDate, Deficiency, InspectDeadline, DateModified)
		values(@ProjectFederalID, @InspectDate, @NextInspect, @InspectStaff, @InspectLetter, 
			@RespDate, @Deficiency, @InspectDeadline, getdate())
		
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