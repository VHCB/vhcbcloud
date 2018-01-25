
create procedure dbo.GetHOPWAEthnicityList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAEthnicityList 1, 1
begin transaction

	begin try

	select HOPWAEthnicID, Ethnic, lv.Description as EthnicName, EthnicNum, he.RowIsActive, he.DateModified
	from HOPWAEthnic he(nolock) 
	join lookupvalues lv(nolock) on he.Ethnic = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or he.RowIsActive = @IsActiveOnly)
		order by he.DateModified desc

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