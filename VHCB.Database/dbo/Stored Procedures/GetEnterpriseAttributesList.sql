
create procedure dbo.GetEnterpriseAttributesList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseAttributesList 1, 1
	begin try
	
		select EnterpriseAttributeID, ProjectID, LKAttributeID, Date, 
		ep.RowIsActive, lv.Description as Attribute 
		from EnterpriseAttributes ep(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = ep.LKAttributeID
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseAttributeID desc
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