﻿
create procedure dbo.AddGrantinfoFYAmt
(
	@GrantInfoId	int,
	@LkYear			int,
	@Amount			decimal(18, 6),
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
		from GrantinfoFYAmt(nolock)
		where LkYear = @LkYear 
			and GrantinfoID = @GrantInfoId
    )
	begin
		insert into GrantinfoFYAmt(GrantinfoID, LkYear, Amount)
		values(@GrantInfoId, @LkYear, @Amount)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from GrantinfoFYAmt(nolock)
		where LkYear = @LkYear 
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