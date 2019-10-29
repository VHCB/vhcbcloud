CREATE  procedure dbo.GetTransactionDetailsByDetailId
(
	@DetailID	int
) as
begin transaction

	begin try
	
	select d.ProjectId, isnull(p.Proj_num, '') ProjectNum, FundId, LkTransType, convert(varchar(30), Amount) Amount, LandUsePermitID, d.RowIsActive
	from Detail d(nolock)
	left join Project p(nolock) on p.ProjectId = d.ProjectID
	where DetailID = @DetailID

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