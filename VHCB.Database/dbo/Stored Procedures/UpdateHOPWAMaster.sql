
create procedure dbo.UpdateHOPWAMaster
(
	@HOPWAID		int, 
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
	@LivingSituationId	int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update HOPWAMaster set HHincludes = @HHincludes, SpecNeeds = @SpecNeeds, WithHIV = @WithHIV, InHousehold = @InHousehold, 
		Minors = @Minors, Gender = @Gender, Age = @Age, Ethnic = @Ethnic, Race = @Race, GMI = @GMI, AMI = @AMI, Beds = @Beds, Notes = @Notes, 
		LivingSituationId = @LivingSituationId, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from HOPWAMaster
	where HOPWAID = @HOPWAID
	
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