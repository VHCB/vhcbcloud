
create procedure dbo.AddConservationAppraisalValue
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
	@FeeValue		money
) as
begin transaction

	begin try
		insert into AppraisalValue(ProjectID, TotAcres, Apbef, Apaft, Aplandopt, Exclusion, EaseValue, Valperacre, Comments, FeeValue)
		values(@ProjectID, @TotAcres, @Apbef, @Apaft, @Aplandopt, @Exclusion, @EaseValue, @Valperacre, @Comments, @FeeValue)

		if not exists
		(
			select 1
			from Conserve(nolock)
			where ProjectID = @ProjectId
		)
		begin
			insert into Conserve(ProjectID, TotalAcres, DateModified)
			values(@ProjectID, @TotAcres, getdate())
		end
		else
		begin
			update conserve set TotalAcres = @TotAcres
			from conserve
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