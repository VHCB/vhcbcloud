
create procedure dbo.UpdateProjectEvent
(
	@ProjectEventID	int,
	@Prog			int, 
	@ProjectID		int, 
	@ApplicantID	int, 
	@EventID		int, 
	@SubEventID		int, 
	@Date			datetime, 
	@Note			nvarchar(max), 
	@UserID			int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	declare @AppNameID int
	set @AppNameID = @ApplicantID
	set @ApplicantID = 0
	select @ApplicantID = ApplicantID from ApplicantAppName(nolock) where AppNameID = @AppNameID

	update ProjectEvent set Prog = @Prog, ProjectID = @ProjectID, ApplicantID = @ApplicantID, EventID= @EventID, SubEventID = @SubEventID, Date = @Date, Note = @Note, UserID = @UserID,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectEvent
	where ProjectEventID = @ProjectEventID
	
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