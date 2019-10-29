CREATE procedure dbo.GetEnterpriseGrantMatchList
(
	@EnterImpGrantID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseGrantMatchList 1, 1
	begin try
	
		select EnterpriseGrantMatchID, EnterImpGrantID, MatchDescID,  
		efj.RowIsActive, lv.Description as MatchDesc, GrantAmt
		from EnterpriseGrantMatch efj(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = efj.MatchDescID
		where EnterImpGrantID = @EnterImpGrantID
			and (@IsActiveOnly = 0 or efj.RowIsActive = @IsActiveOnly)
		order by EnterpriseGrantMatchID desc
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