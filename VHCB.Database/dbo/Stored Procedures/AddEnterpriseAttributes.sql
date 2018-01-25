
create procedure dbo.AddEnterpriseAttributes
(
	@ProjectID			int,
	@LKAttributeID		int,
	@Date				DateTime,
	@isDuplicate			bit output,
	@isActive				bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseAttributes (nolock)
		where ProjectID = @ProjectID and LKAttributeID = @LKAttributeID
    )
	begin
		insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
		values(@ProjectID, @LKAttributeID, @Date)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseAttributes (nolock)
		where ProjectID = @ProjectID and LKAttributeID = @LKAttributeID
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