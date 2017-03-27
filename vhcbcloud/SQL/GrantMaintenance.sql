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

		select GrantinfoID, GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, Admin, Notes, RowIsActive, DateModified
		from GrantInfo
		where  (@VHCBName is null or VHCBName like '%'+ @VHCBName + '%')
			and (@Program is null or Program = @Program)
			and (@LkGrantAgency is null or LkGrantAgency = @LkGrantAgency)
			and RowIsActive = @IsActiveOnly
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
--exec GetGrantInfo 33
	begin try

		select GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, Admin, Notes, RowIsActive, DateModified
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
--exec GetGrantinfoFYAmtList 31, 1
	begin try

		select GrantInfoFY, GrantinfoID, LkYear, Amount, RowIsActive
		from GrantinfoFYAmt (nolock)
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
	
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