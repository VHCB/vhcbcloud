use VHCBSandbox 
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHomeOwnershipList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHomeOwnershipList
go

create procedure GetHomeOwnershipList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetHomeOwnershipList 6625, 1
	select ho.ProjectID, ho.HomeOwnershipID, 
	case isnull(ho.MH, '') when '' then 'No' when 0 then 'No' else 'Yes' end MH, 
	case isnull(ho.Condo, '') when '' then 'No' when 0 then 'No' else 'Yes' end Condo, 
	case isnull(ho.SFD, '') when '' then 'No' when 0 then 'No' else 'Yes' end SFD,  
	ho.RowIsActive,
		isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from HomeOwnership ho(nolock)
	join Address a(nolock) on a.Addressid = ho.AddressId
	where ho.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or ho.RowIsActive = @IsActiveOnly)
	order by ho.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHomeOwnershipAddress]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHomeOwnershipAddress
go

create procedure dbo.AddHomeOwnershipAddress
(
	@ProjectID		int, 
	@AddressID		int, 
	@MH				bit, 
	@Condo			bit, 
	@SFD			bit, 
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
		from HomeOwnership ho(nolock)
		where ho.ProjectId = @ProjectID and AddressID = @AddressID
	)
	begin

		insert into HomeOwnership(ProjectId, AddressID, MH, Condo, SFD)
		values(@ProjectId, @AddressID, @MH, @Condo, @SFD)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  ho.RowIsActive 
		from HomeOwnership ho(nolock)
		where ho.ProjectId = @ProjectID and AddressID = @AddressID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseOwnership]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseOwnership
go

create procedure dbo.UpdateHouseOwnership
(
	@HomeOwnershipID		int, 
	@AddressID		int, 
	@MH				bit,
	@Condo			bit, 
	@SFD			bit, 
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update HomeOwnership set  AddressID = @AddressID, MH = @MH, Condo = @Condo, SFD = @SFD,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from HomeOwnership
	where HomeOwnershipID = @HomeOwnershipID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHomeOwnershipById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHomeOwnershipById
go

create procedure dbo.GetHomeOwnershipById
(
	@HomeOwnershipID	int
) as
begin transaction

	begin try

	select HomeOwnershipID, ProjectId, AddressID, MH, Condo, SFD, RowIsActive 
	from HomeOwnership(nolock)
	where HomeOwnershipID = @HomeOwnershipID
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

/* ProjectHomeOwnership */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectHomeOwnershipList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectHomeOwnershipList
go

create procedure GetProjectHomeOwnershipList  
(
	@HomeOwnershipID	int,
	@IsActiveOnly		bit
)
as
begin
--exec GetProjectHomeOwnershipList 1, 1
	select pho.ProjectHomeOwnershipID, pho.HomeOwnershipID, pho.Owner, dbo.GetApplicantName(pho.Owner) OwnerName, 
		pho.LkLender, dbo.GetApplicantName(pho.LkLender) as LenderName,
		pho.vhfa, pho.RDLoan, pho.VHCBGrant, pho.OwnerApprec, pho.CapImprove, pho.InitFee, pho.ResaleFee, pho.StewFee, pho.AssistLoan, pho.RehabLoan, 
		pho.RowIsActive, pho.DateModified
	from ProjectHomeOwnership pho(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pho.Owner 
	left join LookupValues lv1(nolock) on lv1.TypeID = pho.LkLender 
	where pho.HomeOwnershipID = @HomeOwnershipID
		and (@IsActiveOnly = 0 or pho.RowIsActive = @IsActiveOnly)
	order by pho.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectHomeOwnership]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectHomeOwnership
go

create procedure dbo.AddProjectHomeOwnership
( 
	@HomeOwnershipID	int, 
	@Owner			int, 
	@LkLender		int, 
	@vhfa			bit, 
	@RDLoan			bit, 
	@VHCBGrant		money, 
	@OwnerApprec	money, 
	@CapImprove		money, 
	@InitFee		money, 
	@ResaleFee		money, 
	@StewFee		money, 
	@AssistLoan		money, 
	@RehabLoan		money, 
	@PurchaseDate	date,
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
		from ProjectHomeOwnership pho(nolock)
		where pho.Owner = @Owner and LkLender = @LkLender
	)
	begin

		insert into ProjectHomeOwnership(HomeOwnershipID, Owner, LkLender, vhfa, RDLoan, VHCBGrant, OwnerApprec, CapImprove, 
			InitFee, ResaleFee, StewFee, AssistLoan, RehabLoan, PurchaseDate)
		values(@HomeOwnershipID, @Owner, @LkLender, @vhfa, @RDLoan, @VHCBGrant, @OwnerApprec, @CapImprove, 
			@InitFee, @ResaleFee, @StewFee, @AssistLoan, @RehabLoan, @PurchaseDate)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  pho.RowIsActive 
		from ProjectHomeOwnership pho(nolock)
		where pho.Owner = @Owner and LkLender = @LkLender
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectHomeOwnership]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectHomeOwnership
go

create procedure dbo.UpdateProjectHomeOwnership
(
	@ProjectHomeOwnershipID int,
	@Owner			int, 
	@LkLender		int, 
	@vhfa			bit, 
	@RDLoan			bit, 
	@VHCBGrant		money, 
	@OwnerApprec	money, 
	@CapImprove		money, 
	@InitFee		money, 
	@ResaleFee		money, 
	@StewFee		money, 
	@AssistLoan		money, 
	@RehabLoan		money,
	@PurchaseDate	date,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectHomeOwnership set  Owner = @Owner, LkLender = @LkLender, vhfa = @vhfa, RDLoan = @RDLoan, 
		VHCBGrant = @VHCBGrant, OwnerApprec = @OwnerApprec, CapImprove = @CapImprove, InitFee = @InitFee, 
		ResaleFee = @ResaleFee, StewFee = @StewFee, AssistLoan = @AssistLoan, RehabLoan = @RehabLoan, 
		RowIsActive = @IsRowIsActive, DateModified = getdate(), PurchaseDate = @PurchaseDate
	from ProjectHomeOwnership
	where ProjectHomeOwnershipID = @ProjectHomeOwnershipID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectHomeOwnershipById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectHomeOwnershipById
go

create procedure dbo.GetProjectHomeOwnershipById
(
	@ProjectHomeOwnershipID	int
) as
begin transaction

	begin try

	select ProjectHomeOwnershipID, HomeOwnershipID, Owner, LkLender, vhfa, RDLoan, VHCBGrant, OwnerApprec, CapImprove, 
		InitFee, ResaleFee, StewFee, AssistLoan, RehabLoan, RowIsActive, DateModified, PurchaseDate
	from ProjectHomeOwnership(nolock)
	where ProjectHomeOwnershipID = @ProjectHomeOwnershipID
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
