
create procedure dbo.GetEnterpriseAcresById
(
	@ProjectID	int
)
as
begin transaction
--exec GetEnterpriseAcresById 1
	begin try
	
		select EnterpriseAcresId, AcresInProduction, AcresOwned, AcresLeased, isnull(AcresOwned, 0) + isnull(AcresLeased, 0) as TotalAcres,
		ep.RowIsActive 
		from EnterpriseAcres ep(nolock)
		where ProjectID = @ProjectID
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