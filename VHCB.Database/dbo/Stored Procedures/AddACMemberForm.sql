
create procedure dbo.AddACMemberForm
(
	@ACMemberID		int, 
	@ACFormID		int, 
	@Received		bit, 
	@Date			datetime, 
	@URL			nvarchar(50),
	@Notes			nvarchar(max), 
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
		from ACMemberForm(nolock)
		where ACMemberID = @ACMemberID and ACFormID = @ACFormID
    )
	begin
		insert into ACMemberForm(ACMemberID, ACFormID, Received, Date, URL, Notes)
		values(@ACMemberID, @ACFormID, @Received, @Date, @URL, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ACMemberForm(nolock)
		where ACMemberID = @ACMemberID and ACFormID = @ACFormID
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