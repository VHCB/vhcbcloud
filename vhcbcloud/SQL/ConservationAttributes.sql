use VHCBSandbox
go

select * from conserve where projectid = 1

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

