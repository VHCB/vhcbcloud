use VHCBSandbox 
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingDetailsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingDetailsById
go

create procedure GetHousingDetailsById
(
	@ProjectID		int
)  
as
--exec GetHousingDetailsById 6588
begin
	select h.HousingID, h.LkHouseCat, lv.Description as HouseCat, h.Hsqft, h.TotalUnits, h.Previous, h.NewUnits, h.RelCovenant, 
		h.ResRelease, h.AdaptReuse, h.NewConst, h.Rehab, h.RowIsActive, h.SASH, h.ServSuppUnits
	from Housing h(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = h.LkHouseCat
	where h.ProjectID = @ProjectID  
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitHousingUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitHousingUnits 
go

create procedure SubmitHousingUnits
(
	@HousingID		int,
	@LkHouseCat		int,
	@TotalUnits		int,
	@Hsqft			int,
	@Previous		int,
	@NewUnits		int,
	@RelCovenant	int,
	@ResRelease		Date,
	@IsSash			bit,
	@ServSuppUnits	int	

) as
begin transaction

	begin try

	update Housing set LkHouseCat = @LkHouseCat, TotalUnits = @TotalUnits, Hsqft = @Hsqft, 
	Previous = @Previous, NewUnits = @NewUnits, RelCovenant = @RelCovenant, ResRelease = @ResRelease, Sash = @IsSash, 
	ServSuppUnits = @ServSuppUnits
	
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
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSubTypeList 1, 0
begin
	select  hs.HousingTypeID, hs.LkHouseType, lv.description as HouseType, hs.Units, hs.RowIsActive
	from ProjectHouseSubType hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseType
	where hs.HousingID = @HousingID 
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
		from ProjectHouseSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
    )
	begin
		insert into ProjectHouseSubType(HousingID, LkHouseType, Units, DateModified)
		values(@HousingID, @LkHouseType, @Units, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSubType(nolock)
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingSubType]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingSubType
go

create procedure dbo.UpdateHousingSubType
(
	@HousingTypeID		int,
	@Units				int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ProjectHouseSubType set  Units = @Units, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSubType
	where HousingTypeID = @HousingTypeID

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

  /* ProjectHouseSingleCount (ProjectHouseConsReuseRehab)*/

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHouseSingleCountList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHouseSingleCountList 
go

create procedure GetHouseSingleCountList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHouseSingleCountList 1, 0
begin
	select  hs.ProjectHouseConsReuseRehabID, hs.LkUnitChar, lv.description as Characteristic, hs.Numunits, hs.RowIsActive
	from ProjectHouseConsReuseRehab hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkUnitChar
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseSingleCount]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseSingleCount
go

create procedure dbo.AddHouseSingleCount
(
	@HousingID		int,
	@LkUnitChar		int,
	@Numunits		int,
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
		from ProjectHouseConsReuseRehab(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
    )
	begin
		insert into ProjectHouseConsReuseRehab(HousingID, LkUnitChar, Numunits, DateModified)
		values(@HousingID, @LkUnitChar, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseConsReuseRehab(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseSingleCount]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseSingleCount
go

create procedure dbo.UpdateHouseSingleCount
(
	@ProjectHouseConsReuseRehabID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseConsReuseRehab set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseConsReuseRehab
	where ProjectHouseConsReuseRehabID = @ProjectHouseConsReuseRehabID

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

 /* ProjectHouseAccessAdapt (ProjectHouseMultiCount)*/
 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHouseMultiCountList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHouseMultiCountList 
go

create procedure GetHouseMultiCountList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHouseMultiCountList 1, 0
begin
	select  hs.ProjectHouseAccessAdaptID, hs.LkUnitChar, lv.description as Characteristic, hs.Numunits, hs.RowIsActive
	from ProjectHouseAccessAdapt hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkUnitChar
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseMultiCount]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseMultiCount
go

create procedure dbo.AddHouseMultiCount
(
	@HousingID		int,
	@LkUnitChar		int,
	@Numunits		int,
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
		from ProjectHouseAccessAdapt(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
    )
	begin
		insert into ProjectHouseAccessAdapt(HousingID, LkUnitChar, Numunits, DateModified)
		values(@HousingID, @LkUnitChar, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseAccessAdapt(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseMultiCount]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseMultiCount
go

create procedure dbo.UpdateHouseMultiCount
(
	@ProjectHouseAccessAdaptID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseAccessAdapt set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseAccessAdapt
	where ProjectHouseAccessAdaptID = @ProjectHouseAccessAdaptID

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

/* ProjectSuppServ*/
 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSuppServList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSuppServList 
go

create procedure GetHousingSuppServList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSuppServList 1, 0
begin
	select  hs.ProjectSuppServID, hs.LkSuppServ, lv.description as Service, hs.Numunits, hs.RowIsActive
	from ProjectHouseSuppServ hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkSuppServ
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSuppServ]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSuppServ
go

create procedure dbo.AddHousingSuppServ
(
	@HousingID		int,
	@LkSuppServ		int,
	@Numunits		int,
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
		from ProjectHouseSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
    )
	begin
		insert into ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits, DateModified)
		values(@HousingID, @LkSuppServ, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingSuppServ]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingSuppServ
go

create procedure dbo.UpdateHousingSuppServ
(
	@ProjectSuppServID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseSuppServ set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSuppServ
	where ProjectSuppServID = @ProjectSuppServID

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

/* Secondary Supp Serv*/
 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSecServList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSecServList 
go

create procedure GetHousingSecServList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSecServList 1, 0
begin
	select  hs.ProjectSecSuppServID, hs.LKSecSuppServ, lv.description as Service, hs.Numunits, hs.RowIsActive
	from ProjectHouseSecSuppServ hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LKSecSuppServ
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSecServ]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSecServ
go

create procedure dbo.AddHousingSecServ
(
	@HousingID		int,
	@LKSecSuppServ	int,
	@Numunits		int,
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
		from ProjectHouseSecSuppServ(nolock)
		where HousingID = @HousingID 
			and LKSecSuppServ = @LKSecSuppServ
    )
	begin
		insert into ProjectHouseSecSuppServ(HousingID, LKSecSuppServ, Numunits, DateModified)
		values(@HousingID, @LKSecSuppServ, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSecSuppServ(nolock)
		where HousingID = @HousingID 
			and LKSecSuppServ = @LKSecSuppServ
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingSecServ]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingSecServ
go

create procedure dbo.UpdateHousingSecServ
(
	@ProjectSecSuppServID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseSecSuppServ set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSecSuppServ
	where ProjectSecSuppServID = @ProjectSecSuppServID

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

/* ProjectVHCBAffordUnits */

 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingVHCBAffordUnitsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingVHCBAffordUnitsList 
go

create procedure GetHousingVHCBAffordUnitsList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingVHCBAffordUnitsList 1, 0
begin
	select  hs.ProjectVHCBAffordUnitsID, hs.LkAffordunits, lv.description as VHCB, hs.Numunits, hs.RowIsActive
	from ProjectHouseVHCBAfford hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingVHCBAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingVHCBAffordUnits
go

create procedure dbo.AddHousingVHCBAffordUnits
(
	@HousingID		int,
	@LkAffordunits	int,
	@Numunits		int,
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
		from ProjectHouseVHCBAfford(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
    )
	begin
		insert into ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits, DateModified)
		values(@HousingID, @LkAffordunits, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseVHCBAfford(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingVHCBAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingVHCBAffordUnits
go

create procedure dbo.UpdateHousingVHCBAffordUnits
(
	@ProjectVHCBAffordUnitsID	int,
	@Numunits					int,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectHouseVHCBAfford set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseVHCBAfford
	where ProjectVHCBAffordUnitsID = @ProjectVHCBAffordUnitsID

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

/* Project Age Restrict*/

 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectAgeRestrictList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectAgeRestrictList 
go

create procedure GetProjectAgeRestrictList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetProjectAgeRestrictList 1, 0
begin
	select  hs.ProjectAgeRestrictID, hs.LKAgeRestrict, lv.description as AgeRestriction, hs.Numunits, hs.RowIsActive
	from ProjectHouseAgeRestrict hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LKAgeRestrict
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectAgeRestrict]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectAgeRestrict
go

create procedure dbo.AddProjectAgeRestrict
(
	@HousingID		int,
	@LKAgeRestrict	int,
	@Numunits		int,
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
		from ProjectHouseAgeRestrict(nolock)
		where HousingID = @HousingID 
			and LKAgeRestrict = @LKAgeRestrict
    )
	begin
		insert into ProjectHouseAgeRestrict(HousingID, LKAgeRestrict, Numunits, DateModified)
		values(@HousingID, @LKAgeRestrict, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseAgeRestrict(nolock)
		where HousingID = @HousingID 
			and LKAgeRestrict = @LKAgeRestrict
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectAgeRestrict]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectAgeRestrict
go

create procedure dbo.UpdateProjectAgeRestrict
(
	@ProjectAgeRestrictID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseAgeRestrict set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseAgeRestrict
	where ProjectAgeRestrictID = @ProjectAgeRestrictID

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

