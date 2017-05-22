use VHCBSandbox
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProgramTabs]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProgramTabs
go

create procedure dbo.GetProgramTabs
(
	@LKProgramID	int
)
as
begin transaction
--exec GetProgramTabs 145
	begin try

		select TabName, URL
		from programtab(nolock)
		where LKVHCBProgram = @LKProgramID
        order by taborder
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

create procedure dbo.GetProgramTabsForViability
(
	@ProgramId		int,
	@LKProgramID	int
)
as
begin transaction
--exec GetProgramTabsForViability 5594, 148
	begin try
		declare @ProjectType varchar(40)
		declare @ProgramName varchar(40)

		select @ProjectType =  rtrim(ltrim(lv.Description)) 
		from project p(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = p.LkProjectType
		where ProjectId = @ProgramId

		select @ProgramName =  rtrim(ltrim(lv.Description)) 
		from LookupValues lv(nolock)
		where lv.TypeID = @LKProgramID
		
		if(@ProgramName = 'Viability' and @ProjectType = 'Viability Implementation Grant')
		begin
			select TabName, URL
			from programtab(nolock)
			where TabName = 'Implementation Grant'
			order by taborder
		end
		else
		begin
			select TabName, URL
			from programtab(nolock)
			where LKVHCBProgram = @LKProgramID and TabName <> 'Implementation Grant'
			order by taborder
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