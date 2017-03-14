use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFundName]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFundName
go

CREATE procedure GetFundName
(
	@RowIsActive	bit = true
)
--exec GetFundName 0
as
begin
	select fundid, account, name from Fund 
	where  (@RowIsActive = 0 or RowIsActive = @RowIsActive)
	order by name asc 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFundNumbers]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFundNumbers
go

create procedure GetFundNumbers
(
	@RowIsActive bit = true
)
--exec GetFundNumbers 0
as
Begin
	select fundid, account, name 
	from Fund 
	where  (@RowIsActive = 0 or RowIsActive = @RowIsActive)
	order by account asc
End
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddFund]') and type in (N'P', N'PC'))
drop procedure [dbo].AddFund
go

create procedure dbo.AddFund
(
	@name			nvarchar(35), 
	@abbrv			nvarchar(20), 
	@LkFundType		int, 
	@account		nvarchar(4),
	@LkAcctMethod	int, 
	@DeptID			nvarchar(12) = null,
	@VHCBCode		nvarchar(25) = null,
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
		from Fund(nolock)
		where name = @name 
    )
	begin
		insert into Fund(name, abbrv, LkFundType, account, LkAcctMethod, DeptID, VHCBCode)
		values(@name, @abbrv, @LkFundType, @account, @LkAcctMethod, @DeptID, @VHCBCode)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from Fund(nolock)
		where name = @name 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateFund]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateFund
go

create procedure dbo.UpdateFund
(
	@FundId			int,
	--@name			nvarchar(35), 
	@abbrv			nvarchar(20), 
	@LkFundType		int, 
	@account		nvarchar(4),
	@LkAcctMethod	int, 
	@DeptID			nvarchar(12),
	@VHCBCode		nvarchar(25),
	@IsRowActive		bit
) as
begin transaction

	begin try

	
		update Fund set --name = @name, 
			abbrv = @abbrv, LkFundType = @LkFundType, 
			account = @account, LkAcctMethod = @LkAcctMethod, DeptID = @DeptID, VHCBCode = @VHCBCode,
			RowIsActive = @IsRowActive
		where FundId = @FundId

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SearchFund]') and type in (N'P', N'PC'))
drop procedure [dbo].SearchFund
go

create procedure dbo.SearchFund
(
	@FundId	 int 
	
) as
begin transaction

	begin try

	select FundId, name, abbrv, LkFundType, account, LkAcctMethod, DeptID, VHCBCode, Drawdown, RowIsActive, DateModified
	from Fund(nolock)
	where FundId = @FundId

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