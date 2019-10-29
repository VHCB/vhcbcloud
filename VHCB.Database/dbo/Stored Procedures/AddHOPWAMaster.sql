
create procedure dbo.AddHOPWAMaster
(
	@UUID			nvarchar(6), 
	@HHincludes		nchar(6), 
	@SpecNeeds		int, 
	@WithHIV		int, 
	@InHousehold	int, 
	@Minors			int, 
	@Gender			int, 
	@Age			int, 
	@Ethnic			int, 
	@Race			int, 
	@GMI			money, 
	@AMI			money, 
	@Beds			int, 
	@Notes			nvarchar(max),
	@ProjectId		int,
	@LivingSituationId	int,
	@PrimaryASO		int,
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
		from HOPWAMaster(nolock)
		where UUID = @UUID 
	)
	begin

		insert into HOPWAMaster(UUID, HHincludes, SpecNeeds, WithHIV, InHousehold, Minors, Gender, Age, 
			Ethnic, Race, GMI, AMI, Beds, Notes, ProjectID, LivingSituationId, PrimaryASO)
		values(@UUID, @HHincludes, @SpecNeeds, @WithHIV, @InHousehold, @Minors, @Gender, @Age, 
			@Ethnic, @Race, @GMI, @AMI, @Beds, @Notes, @ProjectId, @LivingSituationId, @PrimaryASO)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from HOPWAMaster(nolock)
		where  UUID = @UUID 
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