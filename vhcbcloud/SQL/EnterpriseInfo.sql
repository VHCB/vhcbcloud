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
--exec GetEnterpriseProductsList 5594, 1
	begin try
	
		select EnterpriseProductsID, ProjectID, LkProduct, StartDate, 
		ep.RowIsActive, lv.SubDescription as Product 
		from EnterpriseProducts ep(nolock)
		left join LookupSubValues lv(nolock) on lv.SubTypeID = ep.LkProduct
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

/* EnterpriseAcres */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseAcresById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseAcresById
go

create procedure dbo.GetEnterpriseAcresById
(
	@ProjectID	int
)
as
begin transaction
--exec GetEnterpriseAcresById 1
	begin try
	
		select EnterpriseAcresId, AcresInProduction, AcresOwned, AcresLeased, isnull(AcresOwned, 0) + isnull(AcresLeased, 0) as TotalAcres,
		ep.RowIsActive 
		from EnterpriseAcres ep(nolock)
		where ProjectID = @ProjectID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseAcres]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseAcres
go

create procedure dbo.AddEnterpriseAcres
(
	@ProjectID				int,
	@AcresInProduction		int,
	@AcresOwned				int,
	@AcresLeased			int,
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
		from EnterpriseAcres (nolock)
		where ProjectID = @ProjectID
    )
	begin
		insert into EnterpriseAcres(ProjectID, AcresInProduction, AcresOwned, AcresLeased)
		values(@ProjectID, @AcresInProduction, @AcresOwned, @AcresLeased)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseAcres (nolock)
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseAcres]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseAcres
go

create procedure dbo.UpdateEnterpriseAcres
(
	@EnterpriseAcresId		int,
	@AcresInProduction		int,
	@AcresOwned				int,
	@AcresLeased			int
) as
begin transaction

	begin try
	
	update EnterpriseAcres set AcresInProduction = @AcresInProduction, AcresOwned = @AcresOwned, AcresLeased = @AcresLeased, DateModified = getdate()
	from EnterpriseAcres 
	where EnterpriseAcresId = @EnterpriseAcresId

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

/* EnterpriseAttributes */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseAttributesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseAttributesList
go

create procedure dbo.GetEnterpriseAttributesList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseAttributesList 1, 1
	begin try
	
		select EnterpriseAttributeID, ProjectID, LKAttributeID, Date, 
		ep.RowIsActive, lv.Description as Attribute 
		from EnterpriseAttributes ep(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = ep.LKAttributeID
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseAttributeID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseAttributesById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseAttributesById
go

create procedure dbo.GetEnterpriseAttributesById
(
	@EnterpriseAttributeID	int
)
as
begin transaction
--exec GetEnterpriseAttributesById 1
	begin try
	
		select LKAttributeID, Date,
		ep.RowIsActive 
		from EnterpriseAttributes ep(nolock)
		where EnterpriseAttributeID = @EnterpriseAttributeID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseAttributes
go

create procedure dbo.AddEnterpriseAttributes
(
	@ProjectID			int,
	@LKAttributeID		int,
	@Date				DateTime,
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
		from EnterpriseAttributes (nolock)
		where ProjectID = @ProjectID and LKAttributeID = @LKAttributeID
    )
	begin
		insert into EnterpriseAttributes(ProjectID, LKAttributeID, Date)
		values(@ProjectID, @LKAttributeID, @Date)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseAttributes (nolock)
		where ProjectID = @ProjectID and LKAttributeID = @LKAttributeID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseAttributes
go

create procedure dbo.UpdateEnterpriseAttributes
(
	@EnterpriseAttributeID		int,
	@Date				DateTime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseAttributes set Date = @Date, RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseAttributes 
	where EnterpriseAttributeID = @EnterpriseAttributeID

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

/* EnterprisePrimeProduct */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitEnterprisePrimeProduct]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitEnterprisePrimeProduct
go

create procedure dbo.SubmitEnterprisePrimeProduct
(
	@ProjectID			int,
	@PrimaryProduct		int
	
) as
begin transaction

	begin try

	if not exists
    (
		select 1
		from EnterprisePrimeProduct (nolock)
		where ProjectID = @ProjectID
    )
	begin
		insert into EnterprisePrimeProduct(ProjectID, PrimaryProduct)
		values(@ProjectID, @PrimaryProduct)
	end
	else
	begin
		update EnterprisePrimeProduct set PrimaryProduct = @PrimaryProduct
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterprisePrimeProduct]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterprisePrimeProduct
go

create procedure dbo.GetEnterprisePrimeProduct
(
	@ProjectID	int
)
as
begin transaction
--exec GetEnterprisePrimeProduct 1
	begin try
	
		select PrimaryProduct, HearAbout, YrManageBus
		from EnterprisePrimeProduct (nolock)
		where ProjectID = @ProjectID
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