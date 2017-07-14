use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseImpGrantsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseImpGrantsById
go

create procedure GetEnterpriseImpGrantsById
(
	@ProjectID		int
)  
as 
--exec GetEnterpriseImpGrantsById 2790
begin
	select EnterImpGrantID, ProjectID, FYGrantRound, Milestone, ProjTitle, ProjDesc, convert(varchar(10), ProjCost) ProjCost, 
		convert(varchar(10), Request) Request, convert(varchar(10), AwardAmt) AwardAmt, AwardDesc, LeveragedFunds, Comments
	from EnterpriseImpGrants (nolock)
	where ProjectID = @ProjectID
	
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseImpGrants]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseImpGrants
go

create procedure dbo.AddEnterpriseImpGrants
( 
	@ProjectID		int, 
	@FYGrantRound	int, 
	@ProjTitle		nvarchar(80), 
	@ProjDesc		nvarchar(max), 
	@ProjCost		money, 
	@Request		money, 
	@AwardAmt		money, 
	@AwardDesc		nvarchar(max), 
	@LeveragedFunds	money, 
	@Comments		nvarchar(max),
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
		from EnterpriseImpGrants(nolock)
		where ProjectID = @ProjectID 
    )
	begin
		insert into EnterpriseImpGrants(ProjectID, FYGrantRound, ProjTitle, ProjDesc, ProjCost, Request, AwardAmt, AwardDesc, LeveragedFunds, Comments)
		values(@ProjectID, @FYGrantRound, @ProjTitle, @ProjDesc, @ProjCost, @Request, @AwardAmt, @AwardDesc, @LeveragedFunds, @Comments)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseImpGrants(nolock)
		where ProjectID = @ProjectID 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseImpGrants]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseImpGrants
go

create procedure dbo.UpdateEnterpriseImpGrants
(
	@EnterImpGrantID	int,
	@FYGrantRound	int, 
	@ProjTitle		nvarchar(80), 
	@ProjDesc		nvarchar(max), 
	@ProjCost		money, 
	@Request		money, 
	@AwardAmt		money, 
	@AwardDesc		nvarchar(max), 
	@LeveragedFunds	money, 
	@Comments		nvarchar(max),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseImpGrants set 
		FYGrantRound = @FYGrantRound, ProjTitle = @ProjTitle, 
		ProjDesc = @ProjDesc, ProjCost = @ProjCost, Request = @Request, AwardAmt = @AwardAmt, 
		AwardDesc = @AwardDesc, LeveragedFunds = @LeveragedFunds, Comments = @Comments,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseImpGrants 
	where EnterImpGrantID = @EnterImpGrantID

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

/* EnterpriseGrantMatch */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseGrantMatchList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseGrantMatchList
go

create procedure dbo.GetEnterpriseGrantMatchList
(
	@EnterImpGrantID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseGrantMatchList 1, 1
	begin try
	
		select EnterpriseGrantMatchID, EnterImpGrantID, MatchDescID,  
		efj.RowIsActive, lv.Description as MatchDesc 
		from EnterpriseGrantMatch efj(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = efj.MatchDescID
		where EnterImpGrantID = @EnterImpGrantID
			and (@IsActiveOnly = 0 or efj.RowIsActive = @IsActiveOnly)
		order by EnterpriseGrantMatchID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseGrantMatch]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseGrantMatch
go

create procedure dbo.AddEnterpriseGrantMatch
(
	@EnterImpGrantID		int,
	@MatchDescID			int,
	@isDuplicate			bit output,
	@isActive				bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseGrantMatch (nolock)
		where EnterImpGrantID = @EnterImpGrantID and MatchDescID = @MatchDescID
    )
	begin
		insert into EnterpriseGrantMatch(EnterImpGrantID, MatchDescID)
		values(@EnterImpGrantID, @MatchDescID)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseGrantMatch (nolock)
		where EnterImpGrantID = @EnterImpGrantID and MatchDescID = @MatchDescID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseGrantMatch]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseGrantMatch
go

create procedure dbo.UpdateEnterpriseGrantMatch
(
	@EnterpriseGrantMatchID int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseGrantMatch set 
		 RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseGrantMatch 
	where EnterpriseGrantMatchID = @EnterpriseGrantMatchID

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

/* Attribute */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseGrantAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseGrantAttributes
go

create procedure dbo.AddEnterpriseGrantAttributes
(
	@EnterImpGrantID		int,
	@LKAttributeID	int,
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
		from EnterpriseGrantAttributes(nolock)
		where EnterImpGrantID = @EnterImpGrantID 
			and LKAttributeID = @LKAttributeID
    )
	begin
		insert into EnterpriseGrantAttributes(EnterImpGrantID, LKAttributeID, DateModified)
		values(@EnterImpGrantID, @LKAttributeID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseGrantAttributes(nolock)
		where EnterImpGrantID = @EnterImpGrantID 
			and LKAttributeID = @LKAttributeID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseGrantAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseGrantAttributes
go

create procedure dbo.UpdateEnterpriseGrantAttributes
(
	@EnterImpAttributeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseGrantAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseGrantAttributes 
	where EnterImpAttributeID = @EnterImpAttributeID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseGrantAttributesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseGrantAttributesList
go

create procedure GetEnterpriseGrantAttributesList
(
	@EnterImpGrantID		int,
	@IsActiveOnly	bit
)  
as
--exec GetEnterpriseGrantAttributesList 1, 1
begin
	select  ca.EnterImpAttributeID, ca.LKAttributeID, lv.Description as Attribute, ca.RowIsActive
	from EnterpriseGrantAttributes ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKAttributeID
	where ca.EnterImpGrantID = @EnterImpGrantID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go