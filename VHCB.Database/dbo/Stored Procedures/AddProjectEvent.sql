
create procedure dbo.AddProjectEvent
(
	@Prog			int, 
	@ProjectID		int, 
	@ApplicantID	int, 
	@EventID		int, 
	@SubEventID		int, 
	@Date			datetime, 
	@Note			nvarchar(max), 
	@UserID			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	declare @AppNameID int
	set @AppNameID = @ApplicantID
	set @ApplicantID = 0
	select @ApplicantID = ApplicantID from ApplicantAppName(nolock) where AppNameID = @AppNameID

	if not exists
    (
		select 1 
		from ProjectEvent(nolock)
		where Prog = @Prog 
			and ProjectID = @ProjectID 
			and ApplicantID = @ApplicantID 
			and EventID = @EventID 
			and SubEventID = @SubEventID
	)
	begin

		insert into ProjectEvent(Prog, ProjectID, ApplicantID, EventID, SubEventID, Date, Note, UserID)
		values(@Prog, @ProjectID, @ApplicantID, @EventID, @SubEventID, @Date, @Note, @UserID)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectEvent(nolock)
		where Prog = @Prog 
			and ProjectID = @ProjectID 
			and ApplicantID = @ApplicantID 
			and EventID = @EventID 
			and SubEventID = @SubEventID
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