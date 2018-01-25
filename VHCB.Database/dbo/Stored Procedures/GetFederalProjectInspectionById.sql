
create procedure dbo.GetFederalProjectInspectionById
(
	@FederalProjectInspectionID	int
) as
begin transaction

	begin try

	select FederalProjectInspectionID, InspectDate, NextInspect, InspectStaff, InspectLetter, 
		RespDate, Deficiency, InspectDeadline, RowIsActive, DateModified
	from FederalProjectInspection(nolock)
	where FederalProjectInspectionID = @FederalProjectInspectionID
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