use vhcbsandbox
go

/* EnterpriseProducts */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseProductsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseProductsList
go

create procedure dbo.GetEnterpriseProductsList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseProductsList 1, 1
	begin try
	
		select EnterpriseProductsID, ProjectID, LkProduct, StartDate, 
		ep.RowIsActive, lv.Description as Product 
		from EnterpriseProducts ep(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = ep.LkProduct
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseProductsID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseProducts]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseProducts
go

create procedure dbo.AddEnterpriseProducts
(
	@ProjectID		int,
	@LkProduct		int,
	@StartDate		datetime,
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
		from EnterpriseProducts (nolock)
		where ProjectID = @ProjectID and LkProduct = @LkProduct
    )
	begin
		insert into EnterpriseProducts(ProjectID, LkProduct, StartDate)
		values(@ProjectID, @LkProduct, @StartDate)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseProducts (nolock)
		where ProjectID = @ProjectID and LkProduct = @LkProduct
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseProducts]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseProducts
go

create procedure dbo.UpdateEnterpriseProducts
(
	@EnterpriseProductsID int,
	@StartDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseProducts set StartDate = @StartDate,
		 RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseProducts 
	where EnterpriseProductsID = @EnterpriseProductsID

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