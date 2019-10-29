
create procedure dbo.AddProjectLeadBldg
(
	@ProjectID		int, 
	@Building		int, 
	@AddressID		int, 
	@Age			int, 
	@Type			int, 
	@LHCUnits		int, 
	@FloodHazard	bit, 
	@FloodIns		bit, 
	@VerifiedBy		int, 
	@InsuredBy		varchar(150), 
	@HistStatus		int, 
	@AppendA		int,
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
		from ProjectLeadBldg plb(nolock)
		where plb.ProjectId = @ProjectID and Building = @Building
	)
	begin

		insert into ProjectLeadBldg(ProjectID, Building, AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
			HistStatus, AppendA)
		values(@ProjectID, @Building, @AddressID, @Age, @Type, @LHCUnits, @FloodHazard, @FloodIns, @VerifiedBy, @InsuredBy, 
			@HistStatus, @AppendA)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  plb.RowIsActive 
		from ProjectLeadBldg plb(nolock)
		where plb.ProjectId = @ProjectID and Building = @Building
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