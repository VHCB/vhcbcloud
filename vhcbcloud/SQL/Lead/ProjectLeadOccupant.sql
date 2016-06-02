use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetBuildingNumbers]') and type in (N'P', N'PC'))
drop procedure [dbo].GetBuildingNumbers
go 

create procedure GetBuildingNumbers
(
	@ProjectID	int
)
as 
--exec GetBuildingNumbers 6625
Begin
	select Building, LeadBldgID from ProjectLeadBldg(nolock) where ProjectID = @ProjectID and RowIsActive = 1
	order by Building
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetBuildingUnitNumbers]') and type in (N'P', N'PC'))
drop procedure [dbo].GetBuildingUnitNumbers
go 

create procedure GetBuildingUnitNumbers
(
	@LeadBldgID	int 
)
as 
--exec GetBuildingUnitNumbers 8
Begin
	select Unit, LeadUnitID from ProjectLeadUnit(nolock) where LeadBldgID = @LeadBldgID and RowIsActive = 1
	order by Unit
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadOccupantList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadOccupantList
go

create procedure GetProjectLeadOccupantList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadOccupantList 6625, 1
	select LeadOccupantID, plo.LeadBldgID, plb.Building, plo.LeadUnitID, plu.Unit, plo.Name, plo.LKAge, lv2.description as Age,
		plo.LKEthnicity, lv.description as Ethnicity, plo.LKRace, lv1.description as Race, plo.RowIsActive
	from ProjectLeadOccupant plo(nolock)
	join ProjectLeadBldg plb(nolock) on plb.LeadBldgID = plo.LeadBldgID
	join ProjectLeadUnit plu(nolock) on plu.LeadUnitID = plo.LeadUnitID
	left join LookupValues lv(nolock) on lv.TypeID = plo.LKEthnicity
	left join LookupValues lv1(nolock) on lv1.TypeID = plo.LKRace
	left join LookupValues lv2(nolock) on lv2.TypeID = plo.LKAge
	where plo.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plo.RowIsActive = @IsActiveOnly)
	order by plo.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectLeadOccupants]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectLeadOccupants
go

create procedure dbo.AddProjectLeadOccupants
(
	@ProjectID		int, 
	@LeadBldgID		int, 
	@LeadUnitID		int,
	@Name			nvarchar(30), 
	@LKAge			int,
	@LKEthnicity	int,
	@LKRace			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	--if not exists
 --   ( 
	--	select 1 
	--	from ProjectLeadOccupant (nolock)
	--	where LeadBldgID = @LeadBldgID and LeadUnitID = @LeadUnitID
	--)
	--begin
		insert into ProjectLeadOccupant(ProjectID, LeadBldgID, LeadUnitID, Name, LKAge, LKEthnicity, LKRace)
		values(@ProjectID, @LeadBldgID, @LeadUnitID, @Name, @LKAge, @LKEthnicity, @LKRace)

		set @isDuplicate = 0
	--end

	--if(@isDuplicate = 1)
	--begin
	--	select @isActive =  RowIsActive 
	--	from ProjectLeadOccupant (nolock)
	--	where LeadBldgID = @LeadBldgID and LeadUnitID = @LeadUnitID
	--end

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectLeadOccupants]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectLeadOccupants
go

create procedure dbo.UpdateProjectLeadOccupants
(
	@LeadOccupantID	int,
	@Name			nvarchar(30), 
	@LKAge			int,
	@LKEthnicity	int,
	@LKRace			int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadOccupant set Name = @Name, LKAge = @LKAge, LKEthnicity = @LKEthnicity, LKRace = @LKRace, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectLeadOccupant
	where LeadOccupantID = @LeadOccupantID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadOccupantById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadOccupantById
go

create procedure GetProjectLeadOccupantById  
(
	@LeadOccupantID		int
)
as
begin
--exec GetProjectLeadOccupantById 1
	select plo.LeadOccupantID, plo.LeadBldgID, plo.LeadUnitID, plo.Name, plo.LKAge,
		plo.LKEthnicity, plo.LKRace, plo.RowIsActive
	from ProjectLeadOccupant plo(nolock)
	where LeadOccupantID = @LeadOccupantID
end
go