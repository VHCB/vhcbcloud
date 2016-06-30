use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetTotalHousingUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].GetTotalHousingUnits
go

create procedure GetTotalHousingUnits  
(
	@ProjectID		int
)
as
begin
--exec GetTotalHousingUnits 6588
	select isnull(TotalUnits, 0) TotalUnits from Housing(nolock) where projectid = @ProjectID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectFederalList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectFederalList
go

create procedure GetProjectFederalList  
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectFederalList 1
	select ProjectFederalID, pf.LkFedProg, lv.description FedProgram, pf.NumUnits, pf.RowIsActive
	from ProjectFederal pf(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pf.LkFedProg
	where (@IsActiveOnly = 0 or pf.RowIsActive = @IsActiveOnly)
	order by pf.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectFederal]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectFederal
go

create procedure dbo.AddProjectFederal
(
	@LkFedProg		int, 
	@ProjectID		int, 
	@NumUnits		int,
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
		from ProjectFederal(nolock)
		where ProjectID = @ProjectID
			and LkFedProg = @LkFedProg
	)
	begin

		insert into ProjectFederal(LkFedProg, ProjectID, NumUnits)
		values(@LkFedProg, @ProjectID, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectFederal(nolock)
		where ProjectID = @ProjectID
			and LkFedProg = @LkFedProg
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectFederal]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectFederal
go

create procedure dbo.UpdateProjectFederal
(
	@ProjectFederalID	int,
	@NumUnits			int,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectFederal set NumUnits = @NumUnits,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectFederal
	where ProjectFederalID = @ProjectFederalID
	
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
