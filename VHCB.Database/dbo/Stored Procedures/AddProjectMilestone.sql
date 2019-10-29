
create procedure dbo.AddProjectMilestone
(
	@Prog			int, 
	@ProjectNum		nvarchar(15), 
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
-- exec dbo.AddProjectMilestone 144, '2000-001-001', 0, 0, 0, '12/18/2016', 'Rama', 3, null, null
	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	declare @ProjNum1 varchar(50)
	declare @ProjectID int
	select @ProjNum1 = dbo.GetHyphenProjectNumber(@ProjectNum)
	--print @ProjNum1
	select @ProjectID = ProjectID from project(nolock) where Proj_num = @ProjNum1
	--print @ProjectID
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
			and ApplicantID = @ApplicantID and ApplicantID != 0  
			and EventID = @EventID  and EventID != 0 
			and SubEventID = @SubEventID and SubEventID != 0
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