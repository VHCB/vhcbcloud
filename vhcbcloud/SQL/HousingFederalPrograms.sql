use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetTotalHousingUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].GetTotalHousingUnits
go

create procedure GetTotalHousingUnits  
(
	@ProjectID		int
)
as
begin
--exec GetTotalHousingUnits 6588
	select isnull(TotalUnits, 0) TotalUnits from Housing(nolock) where projectid = @ProjectID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectFederalList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectFederalList
go

create procedure GetProjectFederalList  
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectFederalList 6612, 1
--select * from ProjectFederal
--select * from projecthomedetail
	select ProjectFederalID, pf.LkFedProg, lv.description FedProgram, pf.NumUnits, pf.RowIsActive
	from ProjectFederal pf(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pf.LkFedProg
	where (@IsActiveOnly = 0 or pf.RowIsActive = @IsActiveOnly) 
		and ProjectID = @ProjectID
	order by pf.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectFederal]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectFederal
go

create procedure dbo.AddProjectFederal
(
	@LkFedProg		int, 
	@ProjectID		int, 
	@NumUnits		int,
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
		from ProjectFederal(nolock)
		where ProjectID = @ProjectID
			and LkFedProg = @LkFedProg
	)
	begin

		insert into ProjectFederal(LkFedProg, ProjectID, NumUnits)
		values(@LkFedProg, @ProjectID, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectFederal(nolock)
		where ProjectID = @ProjectID
			and LkFedProg = @LkFedProg
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectFederal]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectFederal
go

create procedure dbo.UpdateProjectFederal
(
	@ProjectFederalID	int,
	@NumUnits			int,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectFederal set NumUnits = @NumUnits,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectFederal
	where ProjectFederalID = @ProjectFederalID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectHOMEDetail]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectHOMEDetail
go

create procedure dbo.AddProjectHOMEDetail
(
	@ProjectFederalId	int, 
	--@Copyowner			bit, 
	@Recert				int, 
	@LKAffrdPer			int, 
	@AffrdStart			DateTime, 
	@AffrdEnd			DateTime, 
	@CHDO				bit, 
	@CHDORecert			int, 
	@freq				int, 
	@LastInspect		DateTime, 
	@NextInspect		nchar(8), 
	@Staff				int, 
	@InspectDate		DateTime, 
	@InspectLetter		DateTime, 
	@RespDate			DateTime, 
	@IDISNum			nvarchar(4), 
	@Setup				DateTime, 
	@CompleteBy			int, 
	@FundedDate			DateTime, 
	@FundCompleteBy		int,
	@IDISClose			DateTime,
	@IDISCompleteBy		int
) as
begin transaction

	begin try

	insert into ProjectHOMEDetail(ProjectFederalId, Recert, LKAffrdPer, AffrdStart, AffrdEnd, CHDO, CHDORecert, 
		freq, LastInspect, NextInspect, Staff, InspectDate, InspectLetter, RespDate, IDISNum, Setup, CompleteBy, FundedDate, FundCompleteBy,
		IDISClose, IDISCompleteBy)
	values(@ProjectFederalId, @Recert, @LKAffrdPer, @AffrdStart, @AffrdEnd, @CHDO, @CHDORecert, 
		@freq, @LastInspect, @NextInspect, @Staff, @InspectDate, @InspectLetter, @RespDate, @IDISNum, @Setup, @CompleteBy, @FundedDate, 
		@FundCompleteBy, @IDISClose, @IDISCompleteBy)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectHOMEDetail]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectHOMEDetail
go

create procedure dbo.UpdateProjectHOMEDetail
(
	@ProjectFederalDetailID	int,
	--@Copyowner			bit, 
	@Recert				int, 
	@LKAffrdPer			int, 
	@AffrdStart			DateTime, 
	@AffrdEnd			DateTime, 
	@CHDO				bit, 
	@CHDORecert			int, 
	@freq				int, 
	@LastInspect		DateTime, 
	@NextInspect		nchar(8), 
	@Staff				int, 
	@InspectDate		DateTime, 
	@InspectLetter		DateTime, 
	@RespDate			DateTime, 
	@IDISNum			nvarchar(4), 
	@Setup				DateTime, 
	@CompleteBy			int, 
	@FundedDate			DateTime, 
	@FundCompleteBy		int,
	@IDISClose			DateTime,
	@IDISCompleteBy		int
) as
begin transaction

	begin try

	update ProjectHOMEDetail set Recert = @Recert, LKAffrdPer = @LKAffrdPer, AffrdStart = @AffrdStart, 
		AffrdEnd = @AffrdEnd, CHDO = @CHDO, CHDORecert = @CHDORecert, 
		freq = @freq, LastInspect = @LastInspect, NextInspect = @NextInspect, Staff = @Staff, InspectDate = @InspectDate, InspectLetter = @InspectLetter, 
		RespDate = @RespDate, IDISNum = @IDISNum, Setup = @Setup, CompleteBy = @CompleteBy, FundedDate = @FundedDate, FundCompleteBy = @FundCompleteBy,
		IDISClose = @IDISClose, IDISCompleteBy = @IDISCompleteBy, DateModified = getdate()
	from ProjectHOMEDetail
	where ProjectFederalDetailID = @ProjectFederalDetailID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectHOMEDetailById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectHOMEDetailById
go

create procedure dbo.GetProjectHOMEDetailById
(
	@ProjectFederalId	int
) as
begin transaction

	begin try

	select ProjectFederalDetailId, ProjectFederalId, Recert, LKAffrdPer, AffrdStart, AffrdEnd, CHDO, CHDORecert, 
		freq, LastInspect, NextInspect, Staff, InspectDate, InspectLetter, RespDate, 
		IDISNum, Setup, CompleteBy, FundedDate, FundCompleteBy, IDISClose, IDISCompleteBy
	from ProjectHOMEDetail(nolock)
	where ProjectFederalId = @ProjectFederalId
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

/* Rental Affordability */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingFederalAffordList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingFederalAffordList 
go

create procedure GetHousingFederalAffordList
(
	@ProjectFederalID	int,
	@IsActiveOnly		bit
)  
as
--exec GetHousingFederalAffordList 1, 0
begin
	select  fa.FederalAffordID, fa.AffordType, lv.Description as AffordTypeName, fa.NumUnits, fa.RowIsActive
	from FederalAfford fa(nolock)
	join LookupValues lv(nolock) on lv.TypeId = fa.AffordType
	where fa.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fa.RowIsActive = @IsActiveOnly)
		order by fa.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingFederalAfford]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingFederalAfford
go

create procedure dbo.AddHousingFederalAfford
(
	@ProjectFederalID	int, 
	@AffordType			int, 
	@NumUnits			int,
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
		from FederalAfford(nolock)
		where AffordType = @AffordType
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalAfford(ProjectFederalID, AffordType, NumUnits)
		values(@ProjectFederalID, @AffordType, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalAfford(nolock)
		where AffordType = @AffordType
			and ProjectFederalID= @ProjectFederalID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingFederalAfford]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingFederalAfford
go

create procedure dbo.UpdateHousingFederalAfford
(
	@FederalAffordID	int, 
	@NumUnits			int,
	@IsRowActive		bit
) as
begin transaction

	begin try

	update FederalAfford set NumUnits = @NumUnits, 
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalAfford
	where FederalAffordID = @FederalAffordID
	
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

/*  Unit Occupancy  */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFederalUnitList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFederalUnitList
go

create procedure GetFederalUnitList  
(
	@ProjectFederalID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetFederalUnitList 1, 1
	select fu.FederalUnitID, fu.ProjectFederalID, fu.UnitType, lv.Description as UnitTypeName, fu.NumUnits, fu.RowIsActive
	from FederalUnit fu(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fu.UnitType
	where fu.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fu.RowIsActive = @IsActiveOnly)
	order by fu.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingFederalUnit]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingFederalUnit
go

create procedure dbo.AddHousingFederalUnit
(
	@ProjectFederalID	int, 
	@UnitType			int, 
	@NumUnits			int,
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
		from FederalUnit(nolock)
		where UnitType = @UnitType
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalUnit(ProjectFederalID, UnitType, NumUnits)
		values(@ProjectFederalID, @UnitType, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalUnit(nolock)
		where UnitType = @UnitType
			and ProjectFederalID= @ProjectFederalID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingFederalUnit]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingFederalUnit
go

create procedure dbo.UpdateHousingFederalUnit
(
	@FederalUnitID	int, 
	@NumUnits		int,
	@IsRowActive	bit
) as
begin transaction

	begin try

	update FederalUnit set NumUnits = @NumUnits, 
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalUnit
	where FederalUnitID = @FederalUnitID
	
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

/*  Median Income  */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFederalMedIncomeList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFederalMedIncomeList
go

create procedure GetFederalMedIncomeList  
(
	@ProjectFederalID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetFederalMedIncomeList 1, 1
	select fm.FederalMedIncomeID, fm.MedIncome, lv.Description as MedIncomeName, fm.NumUnits, fm.RowIsActive
	from FederalMedIncome fm(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fm.MedIncome
	where fm.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fm.RowIsActive = @IsActiveOnly)
	order by fm.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddFederalMedIncome]') and type in (N'P', N'PC'))
drop procedure [dbo].AddFederalMedIncome
go

create procedure dbo.AddFederalMedIncome
(
	@ProjectFederalID	int, 
	@MedIncome			int, 
	@NumUnits			int,
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
		from FederalMedIncome(nolock)
		where MedIncome = @MedIncome
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalMedIncome(ProjectFederalID, MedIncome, NumUnits)
		values(@ProjectFederalID, @MedIncome, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalMedIncome(nolock)
		where MedIncome = @MedIncome
			and ProjectFederalID= @ProjectFederalID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateFederalMedIncome]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateFederalMedIncome
go

create procedure dbo.UpdateFederalMedIncome
(
	@FederalMedIncomeID	int, 
	@NumUnits		int,
	@IsRowActive	bit
) as
begin transaction

	begin try

	update FederalMedIncome set NumUnits = @NumUnits,
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalMedIncome
	where FederalMedIncomeID = @FederalMedIncomeID
	
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

/* Total Federal Program Units */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetTotalFederalProgramUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].GetTotalFederalProgramUnits
go

create procedure dbo.GetTotalFederalProgramUnits
(
	@ProjectId int
) as
begin transaction
--exec GetTotalFederalProgramUnits 6588
	begin try

	Select isnull(sum(NumUnits), 0)
	from ProjectFederal(nolock) 
	where ProjectId = @ProjectId

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

/* ProjectHomeAffordUnits */

 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingHomeAffordUnitsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingHomeAffordUnitsList 
go

create procedure GetHousingHomeAffordUnitsList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingHomeAffordUnitsList 1, 0
begin
	select  hs.ProjectHomeAffordUnitsID, hs.LkAffordunits, lv.description as Home, hs.Numunits, hs.RowIsActive
	from ProjectHomeAffordUnits hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingHomeAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingHomeAffordUnits
go

create procedure dbo.AddHousingHomeAffordUnits
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
		from ProjectHomeAffordUnits(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
    )
	begin
		insert into ProjectHomeAffordUnits(HousingID, LkAffordunits, Numunits, DateModified)
		values(@HousingID, @LkAffordunits, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHomeAffordUnits(nolock)
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingHomeAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingHomeAffordUnits
go

create procedure dbo.UpdateHousingHomeAffordUnits
(
	@ProjectHomeAffordUnitsID	int,
	@Numunits					int,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectHomeAffordUnits set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHomeAffordUnits
	where ProjectHomeAffordUnitsID = @ProjectHomeAffordUnitsID

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

/* ProjectHOMEInspection */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectHOMEInspectionList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectHOMEInspectionList
go

create procedure GetProjectHOMEInspectionList  
(
	@ProjectFederalDetailID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetProjectHOMEInspectionList 1, 1

	select i.ProjectHOMEInspectionID, i.InspectDate, i.NextInspect, i.InspectStaff, i.InspectLetter, 
		i.RespDate, i.Deficiency, i.InspectDeadline, i.RowIsActive
	from ProjectHOMEInspection i(nolock)
	where i.ProjectFederalDetailID = @ProjectFederalDetailID 
		and (@IsActiveOnly = 0 or i.RowIsActive = @IsActiveOnly)
	order by i.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectHOMEInspection]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectHOMEInspection
go

create procedure dbo.AddProjectHOMEInspection
(
	
	@ProjectFederalDetailID	int, 
	@InspectDate			datetime, 
	@NextInspect			nchar(4), 
	@InspectStaff			int, 
	@InspectLetter			datetime, 
	@RespDate				datetime, 
	@Deficiency				bit, 
	@InspectDeadline		datetime
	--@isDuplicate		bit output,
	--@isActive			bit Output
) as
begin transaction

	begin try

		insert into ProjectHOMEInspection(ProjectFederalDetailID, InspectDate, NextInspect, InspectStaff, InspectLetter, 
			RespDate, Deficiency, InspectDeadline, DateModified)
		values(@ProjectFederalDetailID, @InspectDate, @NextInspect, @InspectStaff, @InspectLetter, 
			@RespDate, @Deficiency, @InspectDeadline, getdate())
		
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectHOMEInspection]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectHOMEInspection
go

create procedure dbo.UpdateProjectHOMEInspection
(
	@ProjectHOMEInspectionID	int, 
	@InspectDate				datetime, 
	@NextInspect				nchar(4), 
	@InspectStaff				int, 
	@InspectLetter				datetime, 
	@RespDate					datetime, 
	@Deficiency					bit, 
	@InspectDeadline			datetime,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectHOMEInspection set  InspectDate = @InspectDate, NextInspect = @NextInspect, InspectStaff = @InspectStaff, 
		InspectLetter = @InspectLetter, RespDate = @RespDate, Deficiency = @Deficiency, InspectDeadline = @InspectDeadline,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHOMEInspection
	where ProjectHOMEInspectionID = @ProjectHOMEInspectionID

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