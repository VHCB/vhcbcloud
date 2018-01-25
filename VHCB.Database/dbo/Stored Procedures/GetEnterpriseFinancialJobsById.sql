CREATE procedure GetEnterpriseFinancialJobsById
(
	@EnterFinancialJobsID		int
)  
as 
--exec GetEnterpriseFinancialJobsById 2790
begin
	select EnterFinancialJobsID, MilestoneID, MSDate, Year, 
	convert(varchar(10), GrossSales) GrossSales, convert(varchar(10), Netincome) Netincome, 
	convert(varchar(10), GrossPayroll) GrossPayroll, FamilyEmp, NonFamilyEmp, 
	convert(varchar(10), Networth) Networth,
	efj.RowIsActive, efj.DateModified 
	from EnterpriseFinancialJobs efj(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = efj.MilestoneID
	where efj.EnterFinancialJobsID = @EnterFinancialJobsID
end