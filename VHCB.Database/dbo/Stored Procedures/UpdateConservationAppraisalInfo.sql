
create procedure dbo.UpdateConservationAppraisalInfo
(
	@AppraisalInfoID int, 
	@LkAppraiser	int, 
	@AppOrdered		datetime, 
	@AppRecd		datetime, 
	@EffDate		datetime, 
	@AppCost		money, 
	@Comment		nvarchar(max), 
	@NRCSSent		datetime, 
	@RevApproved	bit, 
	@ReviewDate		datetime,
	@URL			nvarchar(1500),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update AppraisalInfo set LkAppraiser = @LkAppraiser, AppOrdered = @AppOrdered, AppRecd = @AppRecd, EffDate = @EffDate, 
		AppCost = @AppCost, Comment = @Comment, NRCSSent = @NRCSSent, RevApproved = @RevApproved, ReviewDate = @ReviewDate, 
		RowIsActive = @IsRowIsActive, DateModified = getdate(), URL = @URL
	from AppraisalInfo
	where AppraisalInfoID = @AppraisalInfoID
	
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