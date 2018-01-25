﻿
create procedure dbo.AddConservationMinorAmend
(
	@ProjectId		int,
	@DispDate		datetime,
	@LkConsMinAmend int,
	@ReqDate		datetime,
	@LkDisp			int,
	@URL			nvarchar(1500),		
	@Comments		nvarchar(max),	
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID)
		values(@ProjectId)
		set @ConserveID = @@IDENTITY
	end
	else
	begin
		select @ConserveID = ConserveID 
		from Conserve(nolock) 
		where ProjectID = @ProjectId
	end
	
	if not exists
    (
		select 1
		from ConserveMinorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMinAmend = @LkConsMinAmend
    )
	begin
		insert into ConserveMinorAmend(ConserveID, LkConsMinAmend, ReqDate, LkDisp, DispDate, DateModified, Comments, URL)
		values(@ConserveID, @LkConsMinAmend, @ReqDate, @LkDisp, @DispDate, getdate(), @Comments, @URL)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveMinorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMinAmend = @LkConsMinAmend 
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