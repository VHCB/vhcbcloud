use VHCBSandbox
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveID
go

create procedure GetConserveID
(
	@ProjectID		int,
	@ConserveID		int output
) as
begin transaction

	begin try

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID)
		values(@ProjectId)

		set @ConserveID = @@IDENTITY
	end
	else
	begin
		select @ConserveID = ConserveID 
		from Conserve(nolock) 
		where ProjectID = @ProjectId
	end
	select @ConserveID
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
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveAttribList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveAttribList
go

create procedure GetConserveAttribList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveAttribList 1, 1
begin
	select  ca.ConserveAttribID, ca.LkConsAttrib, lv.Description as Attribute, ca.RowIsActive
	from ConserveAttrib ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkConsAttrib
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveAttribute]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveAttribute
go

create procedure dbo.AddConserveAttribute
(
	@ConserveID		int,
	@LkConsAttrib	int,
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
		from ConserveAttrib(nolock)
		where ConserveID = @ConserveID 
			and LkConsAttrib = @LkConsAttrib
    )
	begin
		insert into ConserveAttrib(ConserveID, LkConsAttrib, DateModified)
		values(@ConserveID, @LkConsAttrib, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAttrib(nolock)
		where  ConserveID = @ConserveID 
			and LkConsAttrib = @LkConsAttrib
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveAttribute]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveAttribute
go

create procedure dbo.UpdateConserveAttribute
(
	@ConserveAttribID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAttrib set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAttrib 
	where ConserveAttribID = @ConserveAttribID

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

/* AffordabilityMechanisms */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAffordabilityMechanismsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAffordabilityMechanismsList
go

create procedure GetAffordabilityMechanismsList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAffordabilityMechanismsList 1, 1
begin
	select  ca.ConserveAffmechID, ca.LkConsAffMech, lv.Description as AffordabilityMechanism, ca.RowIsActive
	from ConserveAffMech ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkConsAffMech
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddAffordabilityMechanism]') and type in (N'P', N'PC'))
drop procedure [dbo].AddAffordabilityMechanism
go

create procedure dbo.AddAffordabilityMechanism
(
	@ConserveID		int,
	@LkConsAffMech	int,
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
		from ConserveAffMech(nolock)
		where ConserveID = @ConserveID 
			and LkConsAffMech = @LkConsAffMech
    )
	begin
		insert into ConserveAffMech(ConserveID, LkConsAffMech, DateModified)
		values(@ConserveID, @LkConsAffMech, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAffMech(nolock)
		where ConserveID = @ConserveID 
			and LkConsAffMech = @LkConsAffMech
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateAffordabilityMechanism]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateAffordabilityMechanism
go

create procedure dbo.UpdateAffordabilityMechanism
(
	@ConserveAffmechID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAffMech set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAffMech 
	where ConserveAffmechID = @ConserveAffmechID

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

/* Public Access */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetPublicAccessList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetPublicAccessList
go

create procedure GetPublicAccessList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAffordabilityMechanismsList 1, 1
begin
	select  ca.ConservePAcessID, ca.LkPAccess, lv.Description as PublicAccess, ca.RowIsActive
	from ConservePAccess ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkPAccess
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddPublicAccess]') and type in (N'P', N'PC'))
drop procedure [dbo].AddPublicAccess
go

create procedure dbo.AddPublicAccess
(
	@ConserveID		int,
	@LkPAccess	int,
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
		from ConservePAccess(nolock)
		where ConserveID = @ConserveID 
			and LkPAccess = @LkPAccess
    )
	begin
		insert into ConservePAccess(ConserveID, LkPAccess, DateModified)
		values(@ConserveID, @LkPAccess, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConservePAccess(nolock)
		where ConserveID = @ConserveID 
			and LkPAccess = @LkPAccess
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdatePublicAccess]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdatePublicAccess
go

create procedure dbo.UpdatePublicAccess
(
	@ConservePAcessID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConservePAccess set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConservePAccess 
	where ConservePAcessID = @ConservePAcessID

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

/* Alternative Energy */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAltEnergyList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAltEnergyList
go

create procedure GetAltEnergyList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAltEnergyList 1, 1
begin
	select  ca.ConsserveAltEnergyID, ca.LkAltEnergy, lv.Description as AlternativeEnergy, ca.RowIsActive
	from ConserveAltEnergy ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkAltEnergy
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddAltEnergy]') and type in (N'P', N'PC'))
drop procedure [dbo].AddAltEnergy
go

create procedure dbo.AddAltEnergy
(
	@ConserveID		int,
	@LkAltEnergy	int,
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
		from ConserveAltEnergy(nolock)
		where ConserveID = @ConserveID 
			and LkAltEnergy = @LkAltEnergy
    )
	begin
		insert into ConserveAltEnergy(ConserveID, LkAltEnergy, DateModified)
		values(@ConserveID, @LkAltEnergy, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAltEnergy(nolock)
		where ConserveID = @ConserveID 
			and LkAltEnergy = @LkAltEnergy
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateAltEnergy]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateAltEnergy
go

create procedure dbo.UpdateAltEnergy
(
	@ConsserveAltEnergyID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAltEnergy set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAltEnergy 
	where ConsserveAltEnergyID = @ConsserveAltEnergyID

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

/* Buffers */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetBuffersList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetBuffersList
go

create procedure GetBuffersList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetBuffersList 1, 1
begin
	select  ca.ConserveBufferID, ca.LkBuffer, lv.Description as BufferType, ca.RowIsActive
	from ConserveBuffer ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkBuffer
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddBuffers]') and type in (N'P', N'PC'))
drop procedure [dbo].AddBuffers
go

create procedure dbo.AddBuffers
(
	@ConserveID		int,
	@LkBuffer		int,
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
		from ConserveBuffer(nolock)
		where ConserveID = @ConserveID 
			and LkBuffer = @LkBuffer
    )
	begin
		insert into ConserveBuffer(ConserveID, LkBuffer, DateModified)
		values(@ConserveID, @LkBuffer, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveBuffer(nolock)
		where ConserveID = @ConserveID 
			and LkBuffer = @LkBuffer
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateBuffers]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateBuffers
go

create procedure dbo.UpdateBuffers
(
	@ConserveBufferID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveBuffer set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveBuffer 
	where ConserveBufferID = @ConserveBufferID

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


/* Owner Types */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetOwnerTypesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetOwnerTypesList
go

create procedure GetOwnerTypesList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetBuffersList 1, 1
begin
	select  ca.ConserveOTypeID, ca.LKOType, lv.Description as OwnerType, ca.RowIsActive
	from ConserveOType ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKOType
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddOwnerType]') and type in (N'P', N'PC'))
drop procedure [dbo].AddOwnerType
go

create procedure dbo.AddOwnerType
(
	@ConserveID		int,
	@LKOType		int,
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
		from ConserveOType(nolock)
		where ConserveID = @ConserveID 
			and LKOType = @LKOType
    )
	begin
		insert into ConserveOType(ConserveID, LKOType, DateModified)
		values(@ConserveID, @LKOType, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveOType(nolock)
		where ConserveID = @ConserveID 
			and LKOType = @LKOType
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateOwnerType]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateOwnerType
go

create procedure dbo.UpdateOwnerType
(
	@ConserveOTypeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveOType set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveOType 
	where ConserveOTypeID = @ConserveOTypeID

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

/* Legal Interest */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLegalInterestsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLegalInterestsList
go

create procedure GetLegalInterestsList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetLegalInterestsList 1, 1
begin
	select  ca.ConserveLegInterestID, ca.LKLegInterest, lv.Description as LegalInterest, ca.RowIsActive
	from ConserveLegInterest ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKLegInterest
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLegalInterest]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLegalInterest
go

create procedure dbo.AddLegalInterest
(
	@ConserveID		int,
	@LKLegInterest	int,
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
		from ConserveLegInterest(nolock)
		where ConserveID = @ConserveID 
			and LKLegInterest = @LKLegInterest
    )
	begin
		insert into ConserveLegInterest(ConserveID, LKLegInterest, DateModified)
		values(@ConserveID, @LKLegInterest, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveLegInterest(nolock)
		where ConserveID = @ConserveID 
			and LKLegInterest = @LKLegInterest
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLegalInterest]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLegalInterest
go

create procedure dbo.UpdateLegalInterest
(
	@ConserveLegInterestID	int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ConserveLegInterest set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveLegInterest 
	where ConserveLegInterestID = @ConserveLegInterestID

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

/* Legal Mechanism  */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLegalMechanismList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLegalMechanismList
go

create procedure GetLegalMechanismList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetLegalMechanismList 1, 1
begin
	select  ca.ConserveLegMechID, ca.LKLegMech, lv.Description as LegalMechanism, ca.RowIsActive
	from ConserveLegMech ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKLegMech
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLegalMechanism]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLegalMechanism
go

create procedure dbo.AddLegalMechanism
(
	@ConserveID		int,
	@LKLegMech		int,
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
		from ConserveLegMech(nolock)
		where ConserveID = @ConserveID 
			and LKLegMech = @LKLegMech
    )
	begin
		insert into ConserveLegMech(ConserveID, LKLegMech, DateModified)
		values(@ConserveID, @LKLegMech, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveLegMech(nolock)
		where ConserveID = @ConserveID 
			and LKLegMech = @LKLegMech
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLegalMechanism]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLegalMechanism
go

create procedure dbo.UpdateLegalMechanism
(
	@ConserveLegMechID	int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ConserveLegMech set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveLegMech 
	where ConserveLegMechID = @ConserveLegMechID

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