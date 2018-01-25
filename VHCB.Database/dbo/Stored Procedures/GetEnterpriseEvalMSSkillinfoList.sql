
create procedure dbo.GetEnterpriseEvalMSSkillinfoList
(
	@EnterPriseEvalID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseEvalMSSkillinfoList 1, 1
	begin try
	
		select EnterEvalSkillTypeID, SkillType, PreLevel, PostLevel, ms.RowIsActive,
		lv.Description as Skill, lv1.description as Pre, lv2.description as Post
		from EnterpriseEvalMSSkillinfo ms(nolock)
		left join LookupValues lv(nolock) on lv.typeid = SkillType
		left join LookupValues lv1(nolock) on lv1.typeid = PreLevel
		left join LookupValues lv2(nolock) on lv2.typeid = PostLevel
		where EnterPriseEvalID = @EnterPriseEvalID
			and (@IsActiveOnly = 0 or ms.RowIsActive = @IsActiveOnly)
		order by EnterPriseEvalID desc
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