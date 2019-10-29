CREATE procedure dbo.AddEnterpriseFinancialJobs
(
	@ProjectID		int, 
	@MilestoneID	int = null,
	@MSDate			date = null,
	@Year			nchar(10),
	@GrossSales		money,
	@Netincome		money,
	@GrossPayroll	money,
	@FamilyEmp		decimal(18,2),
	@NonFamilyEmp	decimal(18,2),
	@Networth		money,
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
		from EnterpriseFinancialJobs(nolock)
		where ProjectID = @ProjectID and StatusPt = @MilestoneID
    )
	begin
		insert into EnterpriseFinancialJobs(ProjectID, StatusPt, MSDate, Year, GrossSales, Netincome, GrossPayroll, FamilyEmp, NonFamilyEmp, Networth)
		values(@ProjectID, @MilestoneID, @MSDate, @Year, @GrossSales, @Netincome, @GrossPayroll, @FamilyEmp, @NonFamilyEmp, @Networth)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseFinancialJobs(nolock)
		where ProjectID = @ProjectID  and StatusPt = @MilestoneID
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