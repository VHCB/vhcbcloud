
create procedure dbo.GetHOPWAMasterDetailsByHOPWAID
(
	@HOPWAID	int
) as
--GetHOPWAMasterDetailsByHOPWAID 1
begin transaction

	begin try

	select UUID, HHincludes,PrimaryASO, SpecNeeds, WithHIV, InHousehold, Minors, Gender, Age, Ethnic, Race, GMI, AMI, Beds, Notes, RowisActive, LivingSituationId
	from HOPWAMaster hm(nolock) 
	where hm.HOPWAID = @HOPWAID

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