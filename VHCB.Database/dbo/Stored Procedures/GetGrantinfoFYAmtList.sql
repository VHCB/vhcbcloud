
create procedure GetGrantinfoFYAmtList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetGrantinfoFYAmtList 62, 1
	begin try

		select GrantInfoFY, GrantinfoID, LkYear, lpn.description as Year, 
		Amount, fy.RowIsActive
		from GrantinfoFYAmt fy(nolock)
		join lookupvalues lpn on lpn.typeid = fy.LkYear
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or fy.RowIsActive = @IsActiveOnly)
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
end