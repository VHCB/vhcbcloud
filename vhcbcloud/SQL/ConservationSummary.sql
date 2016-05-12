use VHCBSandbox
go

/*
select * from Conserve order by datemodified desc
delete from Conserve where conserveid = 7
select * from ConserveEholder
select * from ConserveAcres
select * from ProjectSurfaceWaters

select * from applicantappname

select a.* 
from applicant a(nolock)
join applicantappname aan(nolock) on a.applicantid = aan.applicantid
join appname an(nolock) on aan.appnameid = an.appnameid
where a.individual = 0
Order by An.ApplicantName

*/

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveDetailsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveDetailsById
go

create procedure GetConserveDetailsById
(
	@ProjectID		int
)  
as
--exec GetConserveDetailsById 1
begin
	select  c.ConserveID, c.LkConsTrack, lv.Description as ConservationTrack, c.PrimStew, c.NumEase, c.TotalAcres, c.Wooded, c.Prime, c.Statewide, c.UserID
	from Conserve c(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = c.LkConsTrack
	where c.ProjectID = @ProjectID 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitConserve]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitConserve
go

create procedure SubmitConserve
(
	@ProjectID		int,
	@LkConsTrack	int,
	@NumEase		int,
	@PrimStew		int,
	@TotalAcres		int,
	@Wooded			int,
	@Prime			int,
	@Statewide		int,
	@UserID			int
)
as
--exec SubmitConserve
begin
	begin try

	declare @ConserveID int

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID, LkConsTrack, PrimStew, NumEase, TotalAcres, Wooded, Prime, Statewide, UserID, DateModified)
		values(@ProjectID, @LkConsTrack, @PrimStew, @NumEase, @TotalAcres, @Wooded, @Prime, @Statewide, @UserID, getdate())

		set @ConserveID = @@IDENTITY
	end
	else
	begin
		update Conserve set LkConsTrack = @LkConsTrack, PrimStew = @PrimStew, NumEase = @NumEase, TotalAcres = @TotalAcres, 
			Wooded = @Wooded, Prime = @Prime, Statewide = @Statewide, UserID = @UserID, DateModified = getdate()
		from Conserve
		where ProjectID = @ProjectId 
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
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetPrimaryStewardOrg]') and type in (N'P', N'PC'))
drop procedure [dbo].GetPrimaryStewardOrg
go

create procedure GetPrimaryStewardOrg
as
--exec GetPrimaryStewardOrg
begin
	select a.applicantid, an.ApplicantName 
	from applicant a(nolock)
	join applicantappname aan(nolock) on a.applicantid = aan.applicantid
	join appname an(nolock) on aan.appnameid = an.appnameid
	where a.RowIsActive = 1 and a.individual = 0
	Order by An.ApplicantName	
end
go

/*         ConserveEholder         */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEasementHolder]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEasementHolder 
go

create procedure GetEasementHolder
as
--exec GetEasementHolder
begin
	select a.applicantid, an.ApplicantName 
	from applicant a(nolock)
	join applicantappname aan(nolock) on a.applicantid = aan.applicantid
	join appname an(nolock) on aan.appnameid = an.appnameid
	where a.RowIsActive = 1
	Order by An.ApplicantName	
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveEholderList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveEholderList 
go

create procedure GetConserveEholderList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveEholderList 1, 1
begin
	select  c.ConserveID, a.ConserveEholderID,  a.ApplicantId, an.ApplicantName, a.RowIsActive
	from Conserve c(nolock)
	join ConserveEholder a(nolock) on c.ConserveID = a.ConserveID
	join applicantappname aan(nolock) on a.applicantid = aan.applicantid
	join appname an(nolock) on aan.appnameid = an.appnameid
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveEholder]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveEholder
go

create procedure dbo.AddConserveEholder
(
	@ProjectId		int,
	@ApplicantId	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

	select @ConserveID = ConserveID 
	from Conserve(nolock) 
	where ProjectID = @ProjectId
	
	if not exists
    (
		select 1
		from ConserveEholder(nolock)
		where ConserveID = @ConserveID 
			and ApplicantId = @ApplicantId
    )
	begin
		insert into ConserveEholder(ConserveID, ApplicantId, DateModified)
		values(@ConserveID, @ApplicantId, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveEholder(nolock)
		where ConserveID = @ConserveID 
			and ApplicantId = @ApplicantId
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveEholder]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveEholder
go

create procedure dbo.UpdateConserveEholder
(
	@ConserveEholderID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveEholder set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveEholder 
	where ConserveEholderID = @ConserveEholderID

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

/*         ConserveAcres         */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveAcresList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveAcresList 
go

create procedure GetConserveAcresList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveAcresList 1, 1
begin
	select  c.ConserveID, a.ConserveAcresID, a.LkAcres, lv.Description as Description, a.Acres, a.RowIsActive
	from Conserve c(nolock)
	join ConserveAcres a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkAcres
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveAcres]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveAcres
go

create procedure dbo.AddConserveAcres
(
	@ProjectId		int,
	@LkAcres		int, 
	@Acres			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

	select @ConserveID = ConserveID 
	from Conserve(nolock) 
	where ProjectID = @ProjectId
	
	if not exists
    (
		select 1
		from ConserveAcres(nolock)
		where ConserveID = @ConserveID 
			and LkAcres = @LkAcres
    )
	begin
		insert into ConserveAcres(ConserveID, LkAcres, Acres, DateModified)
		values(@ConserveID, @LkAcres, @Acres, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAcres(nolock)
		where ConserveID = @ConserveID 
			and LkAcres = @LkAcres
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveAcres]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveAcres
go

create procedure dbo.UpdateConserveAcres
(
	@ConserveAcresID	int,
	--@LkAcres			int, 
	@Acres				int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAcres set  Acres = @Acres,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAcres 
	where ConserveAcresID = @ConserveAcresID

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

/*         SurfaceWaters         */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetSurfaceWatersList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetSurfaceWatersList 
go

create procedure GetSurfaceWatersList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetSurfaceWatersList 1, 1
begin
	select  psw.SurfaceWatersID, psw.ProjectID, psw.LKWaterShed, lv.Description as watershed, 
		psw.SubWaterShed, psw.LKWaterBody, lv1.Description as waterbody, psw.FrontageFeet, psw.OtherWater, psw.RowIsActive
	from ProjectSurfaceWaters psw(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = psw.LKWaterShed
	left join LookupValues lv1(nolock) on lv1.TypeID = psw.LKWaterBody
	where psw.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or psw.RowIsActive = @IsActiveOnly)
	order by psw.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectSurfaceWaters]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectSurfaceWaters
go

create procedure dbo.AddProjectSurfaceWaters
(
	@ProjectId		int,
	@LKWaterShed	int,
	@SubWaterShed	nvarchar(75), 
	@LKWaterBody	int, 
	@FrontageFeet	int,
	@OtherWater		nvarchar(75), 
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
		from ProjectSurfaceWaters(nolock)
		where ProjectID = @ProjectId 
			and LKWaterShed = @LKWaterShed
    )
	begin
		insert into ProjectSurfaceWaters(ProjectID, LKWaterShed, SubWaterShed, LKWaterBody, FrontageFeet, OtherWater, DateModified)
		values(@ProjectId, @LKWaterShed, @SubWaterShed, @LKWaterBody, @FrontageFeet, @OtherWater, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectSurfaceWaters(nolock)
		where ProjectID = @ProjectId 
			and LKWaterShed = @LKWaterShed 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectSurfaceWaters]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectSurfaceWaters
go

create procedure dbo.UpdateProjectSurfaceWaters
(
	@SurfaceWatersID	int,
	@SubWaterShed		nvarchar(75), 
	@LKWaterBody		int, 
	@FrontageFeet		int,
	@OtherWater			nvarchar(75), 
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ProjectSurfaceWaters set  SubWaterShed = @SubWaterShed, LKWaterBody = @LKWaterBody, FrontageFeet = @FrontageFeet, OtherWater = @OtherWater,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectSurfaceWaters 
	where SurfaceWatersID = @SurfaceWatersID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectSurfaceWatersById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectSurfaceWatersById
go

create procedure dbo.GetProjectSurfaceWatersById
(
	@SurfaceWatersID	int
) as
begin transaction

	begin try
	
	select LKWaterShed, SubWaterShed, LKWaterBody, FrontageFeet, OtherWater, RowIsActive 
	from ProjectSurfaceWaters 
	where SurfaceWatersID = @SurfaceWatersID

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