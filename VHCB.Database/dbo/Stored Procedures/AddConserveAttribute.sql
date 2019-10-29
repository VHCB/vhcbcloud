
create procedure dbo.AddConserveAttribute
(
	@ConserveID		int,
	@LkConsAttrib	int,
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
		from ConserveAttrib(nolock)
		where ConserveID = @ConserveID 
			and LkConsAttrib = @LkConsAttrib
    )
	begin
		insert into ConserveAttrib(ConserveID, LkConsAttrib, DateModified)
		values(@ConserveID, @LkConsAttrib, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAttrib(nolock)
		where  ConserveID = @ConserveID 
			and LkConsAttrib = @LkConsAttrib
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