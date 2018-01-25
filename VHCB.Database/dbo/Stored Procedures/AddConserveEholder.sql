
create procedure dbo.AddConserveEholder
(
	@ProjectId		int,
	@ApplicantId	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

	select @ConserveID = ConserveID 
	from Conserve(nolock) 
	where ProjectID = @ProjectId
	
	if not exists
    (
		select 1
		from ConserveEholder(nolock)
		where ConserveID = @ConserveID 
			and ApplicantId = @ApplicantId
    )
	begin
		insert into ConserveEholder(ConserveID, ApplicantId, DateModified)
		values(@ConserveID, @ApplicantId, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveEholder(nolock)
		where ConserveID = @ConserveID 
			and ApplicantId = @ApplicantId
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