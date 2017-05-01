use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAct250FarmsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAct250FarmsList
go

create procedure GetAct250FarmsList  
(
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250FarmsList 1
	select act250.Act250FarmID, act250.UsePermit, act250.LkTownDev, lv.Description 'Town of Development', act250.CDist, act250.Type, 
		lv2.description as 'farmType',
		act250.DevName, act250.Primelost, act250.Statelost, act250.TotalAcreslost, 
		act250.AcresDevelop, act250.Developer, an.ApplicantName as 'DeveloperName', act250.AntFunds, act250.MitDate, 
		act250.RowIsActive, act250.DateModified, act250.URL, 
		CASE when isnull(act250.URL, '') = '' then '' else 'Click here' end as URLText
	from  Act250Farm act250(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = act250.LkTownDev
	left join LookupValues lv2(nolock) on lv2.TypeID = act250.Type
	left join applicantappname aan(nolock) on act250.Developer = aan.applicantid
	left join appname an(nolock) on aan.appnameid = an.appnameid
	where (@IsActiveOnly = 0 or act250.RowIsActive = @IsActiveOnly)
	order by act250.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddAct250Farm]') and type in (N'P', N'PC'))
drop procedure [dbo].AddAct250Farm
go

create procedure dbo.AddAct250Farm
(
	@UsePermit		nvarchar(12), 
	@LkTownDev		int, 
	@CDist			int, 
	@Type			int, 
	@DevName		nvarchar(50), 
	@Primelost		int, 
	@Statelost		int, 
	@TotalAcreslost	int, 
	@AcresDevelop	int, 
	@Developer		int, 
	@AntFunds		money, 
	@MitDate		datetime, 
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
		from Act250Farm(nolock)
		where UsePermit = @UsePermit 
	)
	begin

		insert into Act250Farm(UsePermit, LkTownDev, CDist, Type, DevName, Primelost, Statelost, TotalAcreslost, 
			AcresDevelop, Developer, AntFunds, MitDate, URL)
		values(@UsePermit, @LkTownDev, @CDist, @Type, @DevName, @Primelost, @Statelost, @TotalAcreslost, 
			@AcresDevelop, @Developer, @AntFunds, @MitDate, @URL)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250Farm(nolock)
		where UsePermit = @UsePermit
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateAct250Farm]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateAct250Farm
go

create procedure dbo.UpdateAct250Farm
(
	@Act250FarmID	int,
	@LkTownDev		int, 
	@CDist			int, 
	@Type			int, 
	@DevName		nvarchar(50), 
	@Primelost		int, 
	@Statelost		int, 
	@TotalAcreslost	int, 
	@AcresDevelop	int, 
	@Developer		int, 
	@AntFunds		money, 
	@MitDate		datetime, 
	@URL			nvarchar(1500),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250Farm set LkTownDev = @LkTownDev, CDist = @CDist, Type = @Type, DevName = @DevName, Primelost = @Primelost, Statelost = @Statelost, 
		TotalAcreslost = @TotalAcreslost, AcresDevelop = @AcresDevelop, Developer = @Developer, AntFunds = @AntFunds, MitDate = @MitDate,
		RowIsActive = @IsRowIsActive, URL = @URL, DateModified = getdate()
	from Act250Farm
	where Act250FarmID = @Act250FarmID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAct250FarmById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAct250FarmById
go

create procedure GetAct250FarmById  
(
	@Act250FarmID	int
)
as
begin
--exec GetAct250FarmsList 1
	select UsePermit, LkTownDev, CDist, Type, DevName, Primelost, Statelost, TotalAcreslost, 
		AcresDevelop, Developer, convert(varchar(10), AntFunds) AntFunds, MitDate, URL, RowIsActive
	from  Act250Farm act250(nolock)
	where Act250FarmID = @Act250FarmID
	order by act250.DateModified desc
end
go

/*   Act250DevPay  */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAct250DevPayList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAct250DevPayList
go

create procedure GetAct250DevPayList  
(
	@Act250FarmID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250DevPayList 1, 1
	select Act250PayID, AmtRec, DateRec, RowIsActive
	from  Act250DevPay (nolock)
	where Act250FarmID = @Act250FarmID 
		and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
	order by DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddAct250DevPay]') and type in (N'P', N'PC'))
drop procedure [dbo].AddAct250DevPay
go

create procedure dbo.AddAct250DevPay
(
	@Act250FarmID	int, 
	@AmtRec			money, 
	@DateRec		datetime,
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
		from Act250DevPay(nolock)
		where AmtRec = @AmtRec 
			and  DateRec = @DateRec
	)
	begin

		insert into Act250DevPay(Act250FarmID, AmtRec, DateRec)
		values(@Act250FarmID, @AmtRec, @DateRec)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250DevPay(nolock)
		where AmtRec = @AmtRec 
			and  DateRec = @DateRec
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateAct250DevPay]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateAct250DevPay
go

create procedure dbo.UpdateAct250DevPay
(
	@Act250PayID	int, 
	@AmtRec			money, 
	@DateRec		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250DevPay set AmtRec = @AmtRec, DateRec = @DateRec,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from Act250DevPay
	where Act250PayID = @Act250PayID
	
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

/*   VW_Committed_LandUsePermit */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLandUsePermitFinancialsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLandUsePermitFinancialsList
go

create procedure GetLandUsePermitFinancialsList  
(
	@LandUsePermit	nvarchar(12)
)
as
begin
--exec GetLandUsePermitFinancialsList '12345678'
	select Date, Amount, Type, Status
	from VW_Committed_LandUsePermit
	where LandUsePermit = @LandUsePermit
	order by 1 desc
end
go

/*   Potential VHCB Projects   */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAct250ProjectsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAct250ProjectsList
go

create procedure GetAct250ProjectsList  
(
	@Act250FarmID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250ProjectsList 5, 1
	select proj.Act250ProjectID, proj.ProjectID, v.Project_name as ProjectName, proj.LKTownConserve, lv.Description as ConservationTown,
	proj.AmtFunds, proj.DateClosed, proj.RowIsActive, proj.DateModified
	from Act250Projects proj(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = proj.LKTownConserve
	left join project_v v(nolock) on v.project_id = proj.ProjectID and v.defname = 1
	where Act250FarmID = @Act250FarmID 
	and (@IsActiveOnly = 0 or proj.RowIsActive = @IsActiveOnly)
	order by 1 desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddAct250Projects]') and type in (N'P', N'PC'))
drop procedure [dbo].AddAct250Projects
go

create procedure dbo.AddAct250Projects
(
	@Act250FarmID	int, 
	@ProjectID		int, 
	@LKTownConserve	int, 
	@AmtFunds		money, 
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
		from Act250Projects(nolock)
		where ProjectID = @ProjectID 
			and LKTownConserve = @LKTownConserve 
			and AmtFunds = @AmtFunds
	)
	begin

		insert into Act250Projects(Act250FarmID, ProjectID, LKTownConserve, AmtFunds)
		values(@Act250FarmID, @ProjectID, @LKTownConserve, @AmtFunds)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250Projects(nolock)
		where ProjectID = @ProjectID 
			and LKTownConserve = @LKTownConserve 
			and AmtFunds = @AmtFunds
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateAct250Projects]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateAct250Projects
go

create procedure dbo.UpdateAct250Projects
(
	@Act250ProjectID	int, 
	--@ProjectID		int, 
	--@LKTownConserve	int, 
	@AmtFunds		money, 
	--@DateClosed		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250Projects set AmtFunds = @AmtFunds, --DateClosed = @DateClosed,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from Act250Projects
	where Act250ProjectID = @Act250ProjectID

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

/* Project Conservation Town List */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationTownList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationTownList
go

create procedure GetConservationTownList
(
	@ProjectId Int
)
as
begin
--exec GetConservationTownList 6050
	select distinct town,  lv.TypeID
	from projectaddress pa(nolock)
	join address a(nolock) on pa.Addressid = a.addressid
	join LookupValues lv(nolock) on lv.Description = a.town
	where pa.projectid = @ProjectId and isnull(a.town, '') <> ''
	order by town
end
go


select * from Act250Projects

select * from LookupValues where lookuptype = 89