
create procedure dbo.AddEnterpriseGrantAttributes
(
	@EnterImpGrantID		int,
	@LKAttributeID	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseGrantAttributes(nolock)
		where EnterImpGrantID = @EnterImpGrantID 
			and LKAttributeID = @LKAttributeID
    )
	begin
		insert into EnterpriseGrantAttributes(EnterImpGrantID, LKAttributeID, DateModified)
		values(@EnterImpGrantID, @LKAttributeID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseGrantAttributes(nolock)
		where EnterImpGrantID = @EnterImpGrantID 
			and LKAttributeID = @LKAttributeID
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