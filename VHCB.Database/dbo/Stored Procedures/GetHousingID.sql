
create procedure GetHousingID
(
	@ProjectID		int,
	@HousingID		int output
) as
begin transaction

	begin try

	if not exists
    (
		select 1
		from Housing(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Housing(ProjectID)
		values(@ProjectId)

		set @HousingID = @@IDENTITY
	end
	else
	begin
		select @HousingID = HousingID 
		from Housing(nolock) 
		where ProjectID = @ProjectId
	end
	select @HousingID
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