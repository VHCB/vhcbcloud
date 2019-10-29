
create procedure dbo.AddConservationSource
(
	@ProjectId		int,
	@LKBudgetPeriod int,
	@LkConSource	int,
	@Total			decimal(18,2),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID)
		values(@ProjectId)

		set @ConserveID = @@IDENTITY
	end
	else
	begin
		select @ConserveID = ConserveID 
		from Conserve(nolock) 
		where ProjectID = @ProjectId
	end

	declare @ConserveSUID int

	if not exists
    (
		select 1
		from ConserveSU(nolock)
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		update ConserveSU set MostCurrent = 0 where ConserveID = @ConserveID and MostCurrent = 1

		insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified, MostCurrent)
		values(@ConserveID, @LKBudgetPeriod, getdate(), 1)

		set @ConserveSUID = @@IDENTITY
	end
	else
	begin
		select @ConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ConserveSources(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConSource = @LkConSource
    )
	begin
		insert into ConserveSources(ConserveSUID, LkConSource, Total, DateModified)
		values(@ConserveSUID, @LkConSource, @Total, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveSources(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConSource = @LkConSource 
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