
create procedure dbo.UpdateProjectHOMEInspection
(
	@ProjectHOMEInspectionID	int, 
	@InspectDate				datetime, 
	@NextInspect				nchar(4), 
	@InspectStaff				int, 
	@InspectLetter				datetime, 
	@RespDate					datetime, 
	@Deficiency					bit, 
	@InspectDeadline			datetime,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectHOMEInspection set  InspectDate = @InspectDate, NextInspect = @NextInspect, InspectStaff = @InspectStaff, 
		InspectLetter = @InspectLetter, RespDate = @RespDate, Deficiency = @Deficiency, InspectDeadline = @InspectDeadline,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHOMEInspection
	where ProjectHOMEInspectionID = @ProjectHOMEInspectionID

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