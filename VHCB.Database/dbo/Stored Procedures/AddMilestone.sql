
CREATE procedure dbo.AddMilestone
(
	@Prog			int, 
	@ProjectID		int, 
	@AppName		varchar(50), 

	@EventID		int, --Admin Milestone ID
	@SubEventID		int, 

	@ProgEventID	int, --Program Milestone ID
	@ProgSubEventID	int,

	@EntityMSID		int, --Entity MileStone ID
	@EntitySubMSID	int,

	@Date			datetime, 
	@Note			nvarchar(max), 
	@URL			nvarchar(1500),
	@UserID			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction
	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	declare @applicantId int

	Select @applicantId = a.ApplicantId 
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.Applicantname = @AppName


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
		insert into ProjectEvent(Prog, ProjectID, ApplicantID, EventID, SubEventID, 
			ProgEventID, ProgSubEventID, EntityMSID, EntitySubMSID, 
			Date, Note, URL, UserID)
		values(@Prog, @ProjectID, @ApplicantID, @EventID, @SubEventID, 
			@ProgEventID, @ProgSubEventID, @EntityMSID, @EntitySubMSID, 
			@Date, @Note,@URL, @UserID)

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