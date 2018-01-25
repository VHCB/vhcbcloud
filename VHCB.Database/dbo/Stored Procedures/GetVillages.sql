
create procedure dbo.GetVillages
(
	@zip	int
) as
begin transaction
--exec GetVillages 05041
	begin try

	select village from village_v where zip = @zip

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