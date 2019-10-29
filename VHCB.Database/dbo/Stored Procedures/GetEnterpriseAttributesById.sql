
create procedure dbo.GetEnterpriseAttributesById
(
	@EnterpriseAttributeID	int
)
as
begin transaction
--exec GetEnterpriseAttributesById 1
	begin try
	
		select LKAttributeID, Date,
		ep.RowIsActive 
		from EnterpriseAttributes ep(nolock)
		where EnterpriseAttributeID = @EnterpriseAttributeID
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