
create procedure dbo.AddFundToGrantInfo
(
	@GrantInfoId	int,
	@FundId			int,
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
		from FundGrantinfo(nolock)
		where FundID = @FundId 
			and GrantinfoID = @GrantInfoId
    )
	begin
		insert into FundGrantinfo(FundID, GrantinfoID, DateModified)
		values(@FundId, @GrantInfoId, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from FundGrantinfo(nolock)
		where FundID = @FundId 
			and GrantinfoID = @GrantInfoId
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