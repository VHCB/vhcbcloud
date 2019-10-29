
create procedure dbo.UpdateEnterpriseEvalMSSkillinfo
(
	@EnterEvalSkillTypeID int,
	@SkillType		int,
	@PreLevel		int,
	@PostLevel		int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEvalMSSkillinfo set SkillType = @SkillType, PreLevel = @PreLevel, PostLevel = @PostLevel,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEvalMSSkillinfo 
	where EnterEvalSkillTypeID = @EnterEvalSkillTypeID

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