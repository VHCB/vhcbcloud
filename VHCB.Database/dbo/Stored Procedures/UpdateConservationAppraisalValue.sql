
create procedure dbo.UpdateConservationAppraisalValue
(
	@ProjectID		int, 
	@TotAcres		int, 
	@Apbef			money, 
	@Apaft			money, 
	@Aplandopt		money, 
	@Exclusion		money, 
	@EaseValue		money, 
	@Valperacre		money,
	@Comments		nvarchar(max),
	@IsRowIsActive	bit,
	@FeeValue		money
) as
begin transaction

	begin try

	update AppraisalValue set  TotAcres = @TotAcres, Apbef = @Apbef, Apaft = @Apaft, Aplandopt = @Aplandopt, 
		Exclusion = @Exclusion, EaseValue = @EaseValue, Valperacre = @Valperacre, RowIsActive = @IsRowIsActive, DateModified = getdate(),
		Comments = @Comments, FeeValue = @FeeValue
	from AppraisalValue
	where ProjectID = @ProjectID
	
	update conserve set TotalAcres = @TotAcres
	from conserve
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