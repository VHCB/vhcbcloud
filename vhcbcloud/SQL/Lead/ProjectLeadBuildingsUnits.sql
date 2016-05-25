use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadBldgList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadBldgList
go

create procedure GetProjectLeadBldgList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadBldgList 6625, 1
	select LeadBldgID, plb.ProjectID, Building, plb.AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
		HistStatus, AppendA, plb.RowIsActive,
		isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from ProjectLeadBldg plb(nolock)
	join Address a(nolock) on a.Addressid = plb.AddressId
	where plb.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plb.RowIsActive = @IsActiveOnly)
	order by plb.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectLeadBldg]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectLeadBldg
go

create procedure dbo.AddProjectLeadBldg
(
	@ProjectID		int, 
	@Building		int, 
	@AddressID		int, 
	@Age			int, 
	@Type			int, 
	@LHCUnits		int, 
	@FloodHazard	bit, 
	@FloodIns		bit, 
	@VerifiedBy		int, 
	@InsuredBy		varchar(150), 
	@HistStatus		int, 
	@AppendA		int,
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
		from ProjectLeadBldg plb(nolock)
		where plb.ProjectId = @ProjectID and Building = @Building
	)
	begin

		insert into ProjectLeadBldg(ProjectID, Building, AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
			HistStatus, AppendA)
		values(@ProjectID, @Building, @AddressID, @Age, @Type, @LHCUnits, @FloodHazard, @FloodIns, @VerifiedBy, @InsuredBy, 
			@HistStatus, @AppendA)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  plb.RowIsActive 
		from ProjectLeadBldg plb(nolock)
		where plb.ProjectId = @ProjectID and Building = @Building
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectLeadBldg]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectLeadBldg
go

create procedure dbo.UpdateProjectLeadBldg
(
	@LeadBldgID		int, 
	@Building		int, 
	@AddressID		int, 
	@Age			int, 
	@Type			int, 
	@LHCUnits		int, 
	@FloodHazard	bit, 
	@FloodIns		bit, 
	@VerifiedBy		int, 
	@InsuredBy		varchar(150), 
	@HistStatus		int, 
	@AppendA		int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadBldg set  Building = @Building, AddressID = @AddressID, Age = @Age, Type = @Type, LHCUnits = @LHCUnits, 
		FloodHazard = @FloodHazard, FloodIns = @FloodIns, VerifiedBy = @VerifiedBy, InsuredBy = @InsuredBy, 
		HistStatus = @HistStatus, AppendA = @AppendA, RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectLeadBldg
	where LeadBldgID = @LeadBldgID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadBldgById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadBldgById 
go

create procedure GetProjectLeadBldgById
(
	@LeadBldgID int
)  
as
--exec GetProjectLeadBldgById 6588
begin

	select LeadBldgID, ProjectID, Building, AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
		HistStatus, AppendA, RowIsActive
	from ProjectLeadBldg (nolock)
	where LeadBldgID = @LeadBldgID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectAddressListByProjectID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectAddressListByProjectID
go

create procedure [dbo].GetProjectAddressListByProjectID
(
	@ProjectId int
)
as 
--exec GetProjectAddressListByProjectID 6625
Begin

	select a.AddressId, isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from projectAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	where pa.ProjectId = @ProjectId
end
go

/* Unit Info */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadUnitList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadUnitList
go

create procedure GetProjectLeadUnitList  
(
	@LeadBldgID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadUnitList 1, 1
	select LeadUnitID, plb.Building, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, convert(varchar(10), ClearDate, 101) as ClearDate, 
		CertDate, ReCertDate, plu.RowIsActive
	from ProjectLeadUnit plu(nolock)
	join ProjectLeadBldg plb(nolock) on plu.LeadBldgID = plb.LeadBldgID
	where plu.LeadBldgID = @LeadBldgID
		and (@IsActiveOnly = 0 or plu.RowIsActive = @IsActiveOnly)
	order by plu.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectLeadUnit]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectLeadUnit
go
 

create procedure dbo.AddProjectLeadUnit
(
	@LeadBldgID		int, 
	@Unit			int, 
	@EBLStatus		int, 
	@HHCount		int, 
	@Rooms			int, 
	@HHIncome		decimal, 
	@PartyVerified	bit, 
	@IncomeStatus	int, 
	@MatchFunds		decimal, 
	@ClearDate		Datetime, 
	@CertDate		Datetime, 
	@ReCertDate		Datetime,
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
		from ProjectLeadUnit plu(nolock)
		where plu.LeadBldgID = @LeadBldgID and Unit = @Unit
	)
	begin
		insert into ProjectLeadUnit(LeadBldgID, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, 
			ClearDate, CertDate, ReCertDate)
		values(@LeadBldgID, @Unit, @EBLStatus, @HHCount, @Rooms, @HHIncome, @PartyVerified, @IncomeStatus, @MatchFunds, 
			@ClearDate, @CertDate, @ReCertDate)
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  plu.RowIsActive 
		from ProjectLeadUnit plu(nolock)
		where plu.LeadBldgID = @LeadBldgID and Unit = @Unit
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectLeadUnit]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectLeadUnit
go

create procedure dbo.UpdateProjectLeadUnit
(
	@LeadUnitID		int, 
	@EBLStatus		int, 
	@HHCount		int, 
	@Rooms			int, 
	@HHIncome		decimal, 
	@PartyVerified	bit, 
	@IncomeStatus	int, 
	@MatchFunds		decimal, 
	@ClearDate		Datetime, 
	@CertDate		Datetime, 
	@ReCertDate		Datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadUnit set	EBLStatus = @EBLStatus, HHCount = @HHCount, Rooms = @Rooms, HHIncome = @HHIncome, 
		PartyVerified = @PartyVerified, IncomeStatus = @IncomeStatus, MatchFunds = @MatchFunds, ClearDate = @ClearDate,
		CertDate = @CertDate, ReCertDate = @ReCertDate, RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectLeadUnit
	where LeadUnitID = @LeadUnitID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadUnitById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadUnitById 
go

create procedure GetProjectLeadUnitById
(
	@LeadUnitID int
)  
as
--exec GetProjectLeadUnitById 6
begin

	select LeadUnitID, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, convert(varchar(10), ClearDate, 101) as ClearDate, 
		CertDate, ReCertDate, plu.RowIsActive
	from ProjectLeadUnit plu(nolock)
	where plu.LeadUnitID = @LeadUnitID
end
go