
create procedure dbo.GetEnterpriseServProviderDataList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseServProviderDataList 1, 1
	begin try
	
		select EnterpriseMasterServiceProvID, ProjectID, Year, RowIsActive
		from EnterpriseMasterServiceProvider (nolock)
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
		order by year desc

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