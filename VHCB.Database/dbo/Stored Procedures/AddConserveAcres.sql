
create procedure dbo.AddConserveAcres
(
	@ProjectId		int,
	@LkAcres		int, 
	@Acres			int,
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
		from ConserveAcres(nolock)
		where ConserveID = @ConserveID 
			and LkAcres = @LkAcres
    )
	begin
		insert into ConserveAcres(ConserveID, LkAcres, Acres, DateModified)
		values(@ConserveID, @LkAcres, @Acres, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAcres(nolock)
		where ConserveID = @ConserveID 
			and LkAcres = @LkAcres
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