use VHCBSandbox 
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitHousingUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitHousingUnits 
go

create procedure SubmitHousingUnits
(
	@HousingID		int,
	@LkHouseCat		int,
	@TotalUnits		int,
	@IsActiveOnly	bit
) as
begin transaction

	begin try

	update Housing set LkHouseCat = @LkHouseCat, TotalUnits = @TotalUnits
	from Housing(nolock) 
	where HousingID = @HousingID

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


/* SubType */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSubTypeList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSubTypeList 
go

create procedure GetHousingSubTypeList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSubTypeList 6622,26084, 0
begin
	select  hs.HouseSourceID, h.HousingID, hs.LkHouseSource, hs.Total, lv.description SourceName, hs.RowIsActive
	from housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	join houseSource hs(nolock) on hsu.HouseSUID = hs.HouseSUID
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseSource
	where h.ProjectID = @ProjectID 
		and hsu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSubType]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSubType
go

create procedure dbo.AddHousingSubType
(
	@HousingID		int,
	@LkHouseType	int,
	@Units			int,
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
		from HousingSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
    )
	begin
		insert into HousingSubType(HousingID, LkHouseType, Units, DateModified)
		values(@HousingID, @LkHouseType, @Units, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HousingSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
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

