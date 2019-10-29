
create procedure dbo.IsYearExist
(
	@ProjectID	int,
	@Year		int,
	@isDuplicate	bit output
) as
begin transaction
	begin try

	set @isDuplicate = 1

	 if not exists
        (
			select 1
			from EnterpriseMasterServiceProvider
			where ProjectID = @ProjectID and Year = @Year
        )
		begin
			set @isDuplicate = 0
		end

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