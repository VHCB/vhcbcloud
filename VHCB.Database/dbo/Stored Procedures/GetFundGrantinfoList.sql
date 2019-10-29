
create procedure GetFundGrantinfoList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetFundGrantinfoList 62, 1
	begin try

		select FundGrantinfoID, fgi.FundID, name FundName, GrantinfoID, fgi.RowIsActive
		from FundGrantinfo fgi(nolock)
		join Fund f(nolock) on f.fundid = fgi.fundid
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or fgi.RowIsActive = @IsActiveOnly)
	
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