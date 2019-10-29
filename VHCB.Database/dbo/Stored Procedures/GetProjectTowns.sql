
create procedure dbo.GetProjectTowns
as
begin transaction

	begin try
	
		select distinct Town from address a(nolock)
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where isnull(a.Town, '') != '' 
		order by Town

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