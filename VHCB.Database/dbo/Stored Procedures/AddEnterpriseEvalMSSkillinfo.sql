
create procedure dbo.AddEnterpriseEvalMSSkillinfo
(
	@EnterPriseEvalID	int,
	@SkillType		int,
	@PreLevel		int,
	@PostLevel		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseEvalMSSkillinfo (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and SkillType = @SkillType and PreLevel = @PreLevel and PostLevel = @PostLevel
    )
	begin
		insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
		values(@EnterPriseEvalID, @SkillType, @PreLevel, @PostLevel)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseEvalMSSkillinfo (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and SkillType = @SkillType and PreLevel = @PreLevel and PostLevel = @PostLevel
	end

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