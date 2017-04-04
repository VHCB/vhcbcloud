use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SearchGrantInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].SearchGrantInfo
go

create procedure SearchGrantInfo  
(
	@VHCBName		nvarchar(50) = null,
	@Program		int = null,
	@LkGrantAgency	int = null,
	@Grantor		nvarchar(20) = null,
	@IsActiveOnly	bit = 1
)
as
begin
begin try
--exec SearchGrantInfo 'rk', null, null, null, 0
print @VHCBName
		select GrantinfoID, GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, Admin, Notes, RowIsActive, DateModified
		from GrantInfo
		where (@VHCBName is null or VHCBName like '%'+ @VHCBName + '%')
			and (@Program is null or Program = @Program)
			and (@LkGrantAgency is null or LkGrantAgency = @LkGrantAgency)
			and (@Grantor is null or ContactID = @Grantor)
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly) 
		order by VHCBName
	
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
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetGrantInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].GetGrantInfo
go

create procedure GetGrantInfo  
(
	@GrantInfoId	int
)
as
begin
--exec GetGrantInfo 70
	begin try

		select GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, 
		convert(varchar(10), AwardAmt) AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, 
		Admin, Notes, RowIsActive, DateModified
		from GrantInfo
		where GrantinfoID = @GrantInfoId
	
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddGrantInfoV2]') and type in (N'P', N'PC'))
drop procedure [dbo].AddGrantInfoV2
go


create procedure dbo.AddGrantInfoV2
(
	@VHCBName		nvarchar(50),
	@AwardAmt		decimal(16, 2),
	@BeginDate		datetime = null,
	@EndDate		datetime = null,
	@LkGrantAgency	int = null,
	@GrantName		nvarchar(50),
	@ContactID		int = null,
	@AwardNum		nvarchar(25) = null,
	@CFDA			nchar(5) = null,
	@LkGrantSource	int = null, --Grant Type
	@Staff			int = null,
	@Program		int = null,
	@FedFunds		bit,
	@Admin			bit,
	@Match			bit,
	@Fundsrec		bit,
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
		from Grantinfo(nolock)
		where VHCBName = @VHCBName 
			or GrantName = @GrantName
    )
	begin
		insert into Grantinfo(VHCBName, AwardAmt, BeginDate, EndDate, LkGrantAgency, GrantName, Admin, Match, Fundsrec,
		ContactID, AwardNum, CFDA, LkGrantSource, Staff, Program, FedFunds)
		values(@VHCBName, @AwardAmt, @BeginDate, @EndDate, @LkGrantAgency, @GrantName, @Admin, @Match, @Fundsrec,
		@ContactID, @AwardNum, @CFDA, @LkGrantSource, @Staff, @Program, @FedFunds)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from Grantinfo(nolock)
		where VHCBName = @VHCBName 
			or GrantName = @GrantName
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateGrantInfoV2]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateGrantInfoV2
go

create procedure dbo.UpdateGrantInfoV2
(
	@GrantinfoID	int,
	@VHCBName		nvarchar(50),
	@AwardAmt		decimal(16, 2),
	@BeginDate		datetime = null,
	@EndDate		datetime = null,
	@LkGrantAgency	int = null,
	@GrantName		nvarchar(50),
	@ContactID		int = null,
	@AwardNum		nvarchar(25) = null,
	@CFDA			nchar(5) = null,
	@LkGrantSource	int = null, --Grant Type
	@Staff			int = null,
	@Program		int = null,
	@FedFunds		bit,
	@Admin			bit,
	@Match			bit,
	@Fundsrec		bit,
	@RowIsActive	bit
) as
begin transaction

	begin try
	begin
		update Grantinfo set VHCBName = @VHCBName, AwardAmt = @AwardAmt, BeginDate = @BeginDate, EndDate = @EndDate, 
		LkGrantAgency = @LkGrantAgency, GrantName = @GrantName, Admin = @Admin, Match = @Match, Fundsrec = @Fundsrec,
		ContactID = @ContactID, AwardNum = @AwardNum, CFDA = @CFDA, LkGrantSource = @LkGrantSource, Staff = @Staff, 
		Program = @Program, FedFunds = @FedFunds, RowIsActive = @RowIsActive
		from Grantinfo where GrantinfoID = @GrantinfoID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFundGrantinfoList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFundGrantinfoList
go

create procedure GetFundGrantinfoList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetFundGrantinfoList 62, 1
	begin try

		select FundGrantinfoID, fgi.FundID, name FundName, GrantinfoID, fgi.RowIsActive
		from FundGrantinfo fgi(nolock)
		join Fund f(nolock) on f.fundid = fgi.fundid
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or fgi.RowIsActive = @IsActiveOnly)
	
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateFundGrantinfo]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateFundGrantinfo
go

create procedure UpdateFundGrantinfo  
(
	@GrantInfoId	int,
	@RowIsActive	bit
)
as
begin
--exec UpdateFundGrantinfo 32, 0
	begin try

		update FundGrantinfo set RowIsActive = @RowIsActive
		from FundGrantinfo
		where GrantinfoID = @GrantInfoId
	
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddFundToGrantInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].AddFundToGrantInfo
go

create procedure dbo.AddFundToGrantInfo
(
	@GrantInfoId	int,
	@FundId			int,
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
		from FundGrantinfo(nolock)
		where FundID = @FundId 
			and GrantinfoID = @GrantInfoId
    )
	begin
		insert into FundGrantinfo(FundID, GrantinfoID, DateModified)
		values(@FundId, @GrantInfoId, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from FundGrantinfo(nolock)
		where FundID = @FundId 
			and GrantinfoID = @GrantInfoId
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetGrantinfoFYAmtList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetGrantinfoFYAmtList
go

create procedure GetGrantinfoFYAmtList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetGrantinfoFYAmtList 62, 1
	begin try

		select GrantInfoFY, GrantinfoID, LkYear, lpn.description as Year, 
		Amount, fy.RowIsActive
		from GrantinfoFYAmt fy(nolock)
		join lookupvalues lpn on lpn.typeid = fy.LkYear
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or fy.RowIsActive = @IsActiveOnly)
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddGrantinfoFYAmt]') and type in (N'P', N'PC'))
drop procedure [dbo].AddGrantinfoFYAmt
go

create procedure dbo.AddGrantinfoFYAmt
(
	@GrantInfoId	int,
	@LkYear			int,
	@Amount			decimal(18, 6),
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
		from GrantinfoFYAmt(nolock)
		where LkYear = @LkYear 
			and GrantinfoID = @GrantInfoId
    )
	begin
		insert into GrantinfoFYAmt(GrantinfoID, LkYear, Amount)
		values(@GrantInfoId, @LkYear, @Amount)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from GrantinfoFYAmt(nolock)
		where LkYear = @LkYear 
			and GrantinfoID = @GrantInfoId
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateGrantinfoFYAmt]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateGrantinfoFYAmt
go

create procedure UpdateGrantinfoFYAmt  
(
	@GrantInfoFY	int,
	@Amount			decimal(18, 2),
	@RowIsActive	bit
)
as
begin
--exec UpdateGrantinfoFYAmt 32, 0
	begin try

		update GrantinfoFYAmt set Amount = @Amount, RowIsActive = @RowIsActive
		from GrantinfoFYAmt
		where GrantInfoFY = @GrantInfoFY
	
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
end
go

/* GrantMilestones */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetGrantMilestonesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetGrantMilestonesList
go

create procedure GetGrantMilestonesList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetGrantMilestonesList 62, 0
	begin try

		select MilestoneGrantID, GrantInfoID, MilestoneID, lpn.description as Milestone, Date, 
			Note as FullNotes, substring(Note, 0, 25) Note, 
			URL, CASE when isnull(m.URL, '') = '' then '' else 'Click here' end as URLText, m.RowIsActive
		from GrantMilestones m(nolock)
		join lookupvalues lpn on lpn.typeid = m.MilestoneID
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or m.RowIsActive = @IsActiveOnly)
	
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddGrantMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].AddGrantMilestones
go

create procedure dbo.AddGrantMilestones
(
	@GrantInfoID	int, 
	@MilestoneID	int, 
	@Date			datetime,
	@Note			nvarchar(max), 
	@URL			nvarchar(1500)
) as
begin transaction

	begin try

		insert into GrantMilestones(GrantInfoID, MilestoneID, Date, Note, URL)
		values(@GrantInfoID, @MilestoneID, @Date, @Note, @URL)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateGrantMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateGrantMilestones
go

create procedure dbo.UpdateGrantMilestones
(
	@MilestoneGrantID int,
	@MilestoneID	int, 
	@Date			datetime,
	@Note			nvarchar(max), 
	@URL			nvarchar(1500),
	@RowIsActive	bit
)
as
begin transaction

	begin try
	
		update GrantMilestones set MilestoneID = @MilestoneID, Note = @Note, URL = @URL, RowIsActive = @RowIsActive, DateModified = getdate()
		from GrantMilestones 
		where MilestoneGrantID = @MilestoneGrantID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetGrantMilestone]') and type in (N'P', N'PC'))
drop procedure [dbo].GetGrantMilestone
go

create procedure GetGrantMilestone  
(
	@MilestoneGrantID	int
)
as
begin
--exec GetGrantMilestone 1
	begin try

		select MilestoneGrantID, GrantInfoID, MilestoneID, Date, Note, URL, RowIsActive
		from GrantMilestones
		where MilestoneGrantID = @MilestoneGrantID
	
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
end
go

