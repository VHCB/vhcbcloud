
create procedure dbo.GetEnterpriseBusPlanUseList
(
	@EnterpriseEvalID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseBusPlanUseList 1, 1
	begin try
	
		select EnterBusPlanUseID, EnterpriseEvalID, LKBusPlanUsage, bp.RowIsActive,
		lv.Description as BusPlanUsage
		from EnterpriseBusPlanUse bp(nolock)
		left join LookupValues lv(nolock) on lv.typeid = LKBusPlanUsage
		where EnterpriseEvalID = @EnterpriseEvalID
			and (@IsActiveOnly = 0 or bp.RowIsActive = @IsActiveOnly)
		order by EnterBusPlanUseID desc
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