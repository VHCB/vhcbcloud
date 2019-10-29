
create procedure dbo.GetProjectCheckReqDates
(
	@ProjectId		int
) as
--GetProjectCheckReqDates 6530
begin transaction

	begin try
	select top 3 ProjectCheckReqID, convert(varchar(10), CRDate, 101) CRDate
	from ProjectCheckReq 
	where projectid = @ProjectId 
	order by CRDate desc

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