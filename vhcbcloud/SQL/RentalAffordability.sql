use VHCBSandbox
go

--select * from LookupValues where lookuptype = 100
--select * from CountyRents

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetCountyRentsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetCountyRentsList
go

create procedure GetCountyRentsList  
(
	@IsActiveOnly	bit
)
as
begin
--exec GetCountyRentsList 1, 1
	select cr.CountyRentId, cr.FedProgID, lv.description FedProgram, cr.county, lv1.description CountyName, cr.StartDate, cr.EndDate, cr.RowIsActive
	from CountyRents cr(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = cr.FedProgID
	left join LookupValues lv1(nolock) on lv1.TypeID = cr.county
	where (@IsActiveOnly = 0 or cr.RowIsActive = @IsActiveOnly)
	order by cr.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddCountyRent]') and type in (N'P', N'PC'))
drop procedure [dbo].AddCountyRent
go

create procedure dbo.AddCountyRent
(
	@FedProgID		int,
	@county			int,
	@StartDate		datetime, 
	@EndDate		datetime,
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
		from CountyRents(nolock)
		where FedProgID = @FedProgID 
			and county = @county 
			and StartDate = @StartDate 
			and EndDate = @EndDate
	)
	begin

		insert into CountyRents(FedProgID, county, StartDate, EndDate)
		values(@FedProgID, @county, @StartDate, @EndDate)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from CountyRents(nolock)
		where FedProgID = @FedProgID 
			and county = @county 
			and StartDate = @StartDate 
			and EndDate = @EndDate
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateCountyRent]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateCountyRent
go

create procedure dbo.UpdateCountyRent
(
	@CountyRentId	int,
	@FedProgID		int,
	@county			int,
	@StartDate		datetime, 
	@EndDate		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update CountyRents set FedProgID = @FedProgID, county = @county, StartDate = @StartDate, EndDate = @EndDate,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from CountyRents
	where CountyRentId = @CountyRentId
	
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

/*  CountyUnitRents  */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetCountyUnitRentsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetCountyUnitRentsList
go

create procedure GetCountyUnitRentsList  
(
	@CountyRentID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetCountyUnitRentsList 1, 1
	select cur.CountyUnitRentID, cur.UnitType, lv.Description UnitTypeName, cur.HighRent, cur.LowRent, cur.RowIsActive
	from CountyUnitRents cur(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = cur.UnitType
	where CountyRentID = @CountyRentID 
		and (@IsActiveOnly = 0 or cur.RowIsActive = @IsActiveOnly)
	order by cur.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddCountyUnitRent]') and type in (N'P', N'PC'))
drop procedure [dbo].AddCountyUnitRent
go

create procedure dbo.AddCountyUnitRent
(
	@CountyRentID	int, 
	@UnitType		int, 
	@HighRent		money, 
	@LowRent		money,
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
		from CountyUnitRents(nolock)
		where  CountyRentID = @CountyRentID 
			and UnitType = @UnitType
	)
	begin

		insert into CountyUnitRents(CountyRentID, UnitType, HighRent, LowRent)
		values(@CountyRentID, @UnitType, @HighRent, @LowRent)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from CountyUnitRents(nolock)
		where  CountyRentID = @CountyRentID 
			and UnitType = @UnitType
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateCountyUnitRent]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateCountyUnitRent
go

create procedure dbo.UpdateCountyUnitRent
(
	@CountyUnitRentID	int,
	@HighRent			money, 
	@LowRent			money, 
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update CountyUnitRents set HighRent = @HighRent, LowRent = @LowRent,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from CountyUnitRents
	where CountyUnitRentID = @CountyUnitRentID
	
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