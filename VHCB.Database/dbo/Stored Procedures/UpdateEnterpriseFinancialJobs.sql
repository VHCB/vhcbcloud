CREATE procedure dbo.UpdateEnterpriseFinancialJobs
(
	@EnterFinancialJobsID	int,
	@MilestoneID	int = null,
	@MSDate			date = null,
	@Year			nchar(10),
	@GrossSales		money,
	@Netincome		money,
	@GrossPayroll	money,
	@FamilyEmp		int,
	@NonFamilyEmp	int,
	@Networth		money,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseFinancialJobs set 
		MilestoneID = @MilestoneID,
		MSDate = @MSDate,
		Year = @Year,
		GrossSales = @GrossSales,
		Netincome = @Netincome,
		GrossPayroll = @GrossPayroll,
		FamilyEmp = @FamilyEmp,
		NonFamilyEmp = @NonFamilyEmp,
		Networth = @Networth,
		RowIsActive = @RowIsActive, 
		DateModified = getdate()
	from EnterpriseFinancialJobs 
	where EnterFinancialJobsID = @EnterFinancialJobsID

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