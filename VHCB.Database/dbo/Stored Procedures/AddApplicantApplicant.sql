
create procedure dbo.AddApplicantApplicant
(
	@ApplicantId				int,
	@AttachedApplicantId		int,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from ApplicantApplicant(nolock)
		where ApplicantId = @ApplicantId 
			and AttachedApplicantId = @AttachedApplicantId
    )
	begin
		insert into ApplicantApplicant(ApplicantId, AttachedApplicantId)
		values(@ApplicantId, @AttachedApplicantId)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ApplicantApplicant(nolock)
		where ApplicantId = @ApplicantId 
			and AttachedApplicantId = @AttachedApplicantId
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