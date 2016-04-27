use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveSourcesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveSourcesList 
go

create procedure GetConserveSourcesList
(
	@ProjectID		int,
	@LKBudgetPeriod int
)  
as
--exec GetConserveSourcesList 6588,26083
begin
	select  cs.ConserveSourcesID, c.ConserveID, cs.LkConSource, cs.Total, lv.description SourceName
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveSources cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConSource
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		order by cs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveUsesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveUsesList 
go

create procedure GetConserveUsesList
(
	@ProjectID		int,
	@LKBudgetPeriod int
)  
as
--exec GetConserveUsesList 1,26083
begin
	select  cs.ConserveUsesID, c.ConserveID, 
	cs.LkConUseVHCB, cs.VHCBTotal, lv.description VHCBUseName, 
	cs.LkConUseOther, cs.OtherTotal, lv1.Description OtherUseName,
	cs.VHCBTotal + cs.OtherTotal 'Total'
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveUses cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConUseVHCB
	join LookupValues lv1(nolock) on lv1.TypeId = cs.LkConUseOther
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		order by cs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationSource]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationSource
go

create procedure dbo.AddConservationSource
(
	@ProjectId		int,
	@LKBudgetPeriod int,
	@LkConSource	int,
	@Total			decimal
) as
begin transaction

	begin try

	declare @ConserveID int

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

	declare @ConserveSUID int

	if not exists
    (
		select 1
		from ConserveSU(nolock)
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified)
		values(@ConserveID, @LKBudgetPeriod, getdate())

		set @ConserveSUID = @@IDENTITY
	end
	else
	begin
		select @ConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	insert into ConserveSources(ConserveSUID, LkConSource, Total, DateModified)
	values(@ConserveSUID, @LkConSource, @Total, getdate())

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


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationSource]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationSource
go

create procedure dbo.UpdateConservationSource
(
	@ConserveSourcesID	int,
	@LkConSource		int,
	@Total				decimal
) as
begin transaction

	begin try
	
	update ConserveSources set LkConSource = @LkConSource, Total = @Total, DateModified = getdate()
	from ConserveSources where ConserveSourcesID = @ConserveSourcesID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationUse]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationUse
go

create procedure dbo.AddConservationUse
(
	@ProjectId		int,
	@LKBudgetPeriod int,
	@LkConUseVHCB	int,
	@VHCBTotal		decimal,
	@LkConUseOther	int,
	@OtherTotal		decimal
) as
begin transaction

	begin try

	declare @ConserveID int

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

	declare @ConserveSUID int

	if not exists
    (
		select 1
		from ConserveSU(nolock)
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified)
		values(@ConserveID, @LKBudgetPeriod, getdate())

		set @ConserveSUID = @@IDENTITY
	end
	else
	begin
		select @ConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	insert into ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal)
	values(@ConserveSUID, @LkConUseVHCB, @VHCBTotal, @LkConUseOther, @OtherTotal)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationUses]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationUses
go

create procedure dbo.GetConservationUses
(
	@UsesDescription varchar(10)
) as
begin transaction
-- exec GetConservationUses 'VHCB'
	begin try

	if(@UsesDescription = 'vhcb')
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 99 
			and description like 'vhcb%'
	end
	else
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 99 
			and description not like 'vhcb%'

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


