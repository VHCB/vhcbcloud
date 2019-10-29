
create procedure dbo.AddLoanEvent
(
	@LoanID			int, 
	@Description	nvarchar(max),
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
		from LoanEvents(nolock)
		where LoanID = @LoanID 
			and Description = @Description
	)
	begin

		insert into LoanEvents(LoanID, Description)
		values(@LoanID, @Description)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from LoanEvents(nolock)
		where LoanID = @LoanID 
			and Description = @Description
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