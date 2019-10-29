
create procedure dbo.AddEnterpriseProducts
(
	@ProjectID		int,
	@LkProduct		int,
	@StartDate		datetime,
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
		from EnterpriseProducts (nolock)
		where ProjectID = @ProjectID and LkProduct = @LkProduct
    )
	begin
		insert into EnterpriseProducts(ProjectID, LkProduct, StartDate)
		values(@ProjectID, @LkProduct, @StartDate)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseProducts (nolock)
		where ProjectID = @ProjectID and LkProduct = @LkProduct
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