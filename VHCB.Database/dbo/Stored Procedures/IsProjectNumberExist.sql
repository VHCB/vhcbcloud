
create procedure dbo.IsProjectNumberExist
(
	@ProjectNumber	nvarchar(12),
	@isDuplicate	bit output
) as
begin transaction
--exec IsProjectNumberExist '1111-111-111', null
	begin try

	set @isDuplicate = 1

	 if not exists
        (
			select 1
			from project
			where proj_num = @ProjectNumber
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