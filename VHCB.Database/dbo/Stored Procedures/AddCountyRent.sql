
create procedure dbo.AddCountyRent
(
	@FedProgID		int,
	@county			int,
	@StartDate		datetime, 
	@EndDate		datetime,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from CountyRents(nolock)
		where FedProgID = @FedProgID 
			and county = @county 
			and StartDate = @StartDate 
			and EndDate = @EndDate
	)
	begin

		insert into CountyRents(FedProgID, county, StartDate, EndDate)
		values(@FedProgID, @county, @StartDate, @EndDate)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from CountyRents(nolock)
		where FedProgID = @FedProgID 
			and county = @county 
			and StartDate = @StartDate 
			and EndDate = @EndDate
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