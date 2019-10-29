
create procedure dbo.AddConservationAppraisalInfo
(
	@AppraisalID	int, 
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
		from AppraisalInfo(nolock)
		where LkAppraiser = @LkAppraiser and AppOrdered = @AppOrdered
	)
	begin

		insert into AppraisalInfo(AppraisalID, LkAppraiser, AppOrdered, AppRecd, EffDate, AppCost, 
			Comment, NRCSSent, RevApproved, ReviewDate, URL)
		values(@AppraisalID, @LkAppraiser, @AppOrdered, @AppRecd, @EffDate, @AppCost, 
			@Comment, @NRCSSent, @RevApproved, @ReviewDate, @URL)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from AppraisalInfo(nolock)
		where LkAppraiser = @LkAppraiser and AppOrdered = @AppOrdered
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