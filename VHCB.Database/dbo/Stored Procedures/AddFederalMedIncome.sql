
create procedure dbo.AddFederalMedIncome
(
	@ProjectFederalID	int, 
	@MedIncome			int, 
	@NumUnits			int,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from FederalMedIncome(nolock)
		where MedIncome = @MedIncome
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalMedIncome(ProjectFederalID, MedIncome, NumUnits)
		values(@ProjectFederalID, @MedIncome, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalMedIncome(nolock)
		where MedIncome = @MedIncome
			and ProjectFederalID= @ProjectFederalID
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