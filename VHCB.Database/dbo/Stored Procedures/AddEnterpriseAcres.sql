
create procedure dbo.AddEnterpriseAcres
(
	@ProjectID				int,
	@AcresInProduction		int,
	@AcresOwned				int,
	@AcresLeased			int,
	@isDuplicate			bit output,
	@isActive				bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseAcres (nolock)
		where ProjectID = @ProjectID
    )
	begin
		insert into EnterpriseAcres(ProjectID, AcresInProduction, AcresOwned, AcresLeased)
		values(@ProjectID, @AcresInProduction, @AcresOwned, @AcresLeased)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseAcres (nolock)
		where ProjectID = @ProjectID
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