CREATE procedure dbo.GetEnterprisePrimeProduct
(
	@ProjectID	int
)
as
begin transaction
--exec GetEnterprisePrimeProduct 1
	begin try
	
		select PrimaryProduct, HearAbout, YrManageBus, OtherNames
		from EnterprisePrimeProduct (nolock)
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