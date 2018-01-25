
create procedure dbo.GetEnterpriseProductsList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseProductsList 5594, 1
	begin try
	
		select EnterpriseProductsID, ProjectID, LkProduct, StartDate, 
		ep.RowIsActive, lv.SubDescription as Product 
		from EnterpriseProducts ep(nolock)
		left join LookupSubValues lv(nolock) on lv.SubTypeID = ep.LkProduct
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseProductsID desc
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