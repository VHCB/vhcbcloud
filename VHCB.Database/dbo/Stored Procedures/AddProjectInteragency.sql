
create procedure dbo.AddProjectInteragency
(
	@ProjectID		int,
	@LkInteragency	int,
	@Numunits		int,
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
		from ProjectInteragency(nolock)
		where ProjectID = @ProjectID 
			and LkInteragency = @LkInteragency
    )
	begin
		insert into ProjectInteragency(ProjectID, LkInteragency, Numunits, DateModified)
		values(@ProjectID, @LkInteragency, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectInteragency(nolock)
		where ProjectID = @ProjectID 
			and LkInteragency = @LkInteragency
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