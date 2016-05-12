use VHCBSandbox 
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitHousing]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitHousing 
go

create procedure SubmitHousing
(
	@ProjectID		int,
	@LkHouseCat		int,
	@TotalUnits		int,
	@IsActiveOnly	bit
) as
begin transaction

	begin try

	declare @HousingID int

	if not exists
    (
		select 1
		from Housing(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Housing(ProjectID, LkHouseCat, TotalUnits)
		values(@ProjectId, @LkHouseCat, @TotalUnits)
	end
	else
	begin
		update Housing set LkHouseCat = @LkHouseCat, TotalUnits = @TotalUnits
		from Housing(nolock) 
		where ProjectID = @ProjectId
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSubType]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSubType
go

create procedure dbo.AddHousingSubType
(
[HousingID]
	@ProjectId		int,
	@LkConsMajAmend int,
	@ReqDate		datetime,
	@LkDisp			int,
	@DispDate		datetime,
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
		from ConserveMajorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMajAmend = @LkConsMajAmend
    )
	begin
		insert into ConserveMajorAmend(ConserveID, LkConsMajAmend, ReqDate, LkDisp, DispDate, DateModified)
		values(@ConserveID, @LkConsMajAmend, @ReqDate, @LkDisp, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveMajorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMajAmend = @LkConsMajAmend 
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
go

