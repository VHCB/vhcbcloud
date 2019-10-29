CREATE procedure dbo.SubmitEnterprisePrimeProduct
(
	@ProjectID			int,
	@PrimaryProduct		int,
	@YrManageBus		nvarchar(5),
	@HearAbout			int,
	@OtherNames			nvarchar(150)
) as
begin transaction

	begin try

	if not exists
    (
		select 1
		from EnterprisePrimeProduct (nolock)
		where ProjectID = @ProjectID
    )
	begin
		insert into EnterprisePrimeProduct(ProjectID, PrimaryProduct, HearAbout, YrManageBus, OtherNames)
		values(@ProjectID, @PrimaryProduct, @HearAbout, @YrManageBus, @OtherNames)
	end
	else
	begin
		update EnterprisePrimeProduct set PrimaryProduct = @PrimaryProduct, HearAbout = @HearAbout, YrManageBus = @YrManageBus, OtherNames = @OtherNames
		where ProjectID = @ProjectID
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