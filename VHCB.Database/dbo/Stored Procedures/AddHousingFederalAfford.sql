
create procedure dbo.AddHousingFederalAfford
(
	@ProjectFederalID	int, 
	@AffordType			int, 
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
		from FederalAfford(nolock)
		where AffordType = @AffordType
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalAfford(ProjectFederalID, AffordType, NumUnits)
		values(@ProjectFederalID, @AffordType, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalAfford(nolock)
		where AffordType = @AffordType
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