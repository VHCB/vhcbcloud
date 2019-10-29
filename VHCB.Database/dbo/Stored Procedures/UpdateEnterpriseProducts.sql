
create procedure dbo.UpdateEnterpriseProducts
(
	@EnterpriseProductsID int,
	@StartDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseProducts set StartDate = @StartDate,
		 RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseProducts 
	where EnterpriseProductsID = @EnterpriseProductsID

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