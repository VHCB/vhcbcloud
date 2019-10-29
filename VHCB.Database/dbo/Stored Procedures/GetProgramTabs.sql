
create procedure dbo.GetProgramTabs
(
	@LKProgramID	int
)
as
begin transaction
--exec GetProgramTabs 145
	begin try

		select TabName, URL
		from programtab(nolock)
		where LKVHCBProgram = @LKProgramID
        order by taborder
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