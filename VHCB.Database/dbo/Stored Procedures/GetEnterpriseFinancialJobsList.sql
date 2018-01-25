
create procedure dbo.GetEnterpriseFinancialJobsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseFinancialJobsList 1, 1
	begin try
	
		select EnterFinancialJobsID, MilestoneID, MSDate, Year, GrossSales, Netincome, GrossPayroll, FamilyEmp, NonFamilyEmp, 
		efj.RowIsActive, lv.Description as Milestone 
		from EnterpriseFinancialJobs efj(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = efj.MilestoneID
		where efj.ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or efj.RowIsActive = @IsActiveOnly)
		order by EnterFinancialJobsID desc
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