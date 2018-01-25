
create procedure dbo.GetConservePlansById
(
	@ConservePlanID	int
) as
begin transaction
-- GetConservePlansById 2
	begin try
	
	select ConservePlanID, ConserveID, LKManagePlan, DispDate, Comments, URL, RowIsActive, DateModified
	from ConservePlan
	where ConservePlanID = @ConservePlanID

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