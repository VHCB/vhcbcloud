
create procedure dbo.GetProjectHOMEInspectionById
(
	@ProjectHOMEInspectionID	int
) as
begin transaction

	begin try

	select ProjectFederalDetailID, InspectDate, NextInspect, InspectStaff, InspectLetter, 
		RespDate, Deficiency, InspectDeadline, RowIsActive, DateModified
	from ProjectHOMEInspection(nolock)
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