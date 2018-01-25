
create procedure dbo.GetHOPWAMasterList
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAMasterList 6530, 1
begin transaction

	begin try

	select HOPWAID, UUID, HHincludes, PrimaryASO, lv.description as PrimaryASOST,  WithHIV, InHousehold, Minors, Gender, Age, Ethnic, 
		Race, GMI, AMI, Beds, hm.RowisActive, hm.DateModified, substring(hm.Notes, 0, 25) Notes, hm.Notes as FullNotes
	from HOPWAMaster hm(nolock) 
	left join lookupvalues lv(nolock) on hm.PrimaryASO = lv.TypeID
	where ProjectId = @ProjectId and (@IsActiveOnly = 0 or hm.RowIsActive = @IsActiveOnly)
		order by hm.UUID asc

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