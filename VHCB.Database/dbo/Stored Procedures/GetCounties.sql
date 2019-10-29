
create procedure dbo.GetCounties
as
begin transaction

	begin try

		select distinct county 
		from address a(nolock)
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where isnull(a.county, '') != '' 
		order by county

		--select distinct county from CountyTown
		--order by county

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