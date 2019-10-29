CREATE procedure dbo.GetRelatedProjectList
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
begin transaction
--exec GetRelatedProjectList 6588, 1
	begin try

	select  pr.RelProjectId, p.Proj_num, lv.Description as ProjectName, pr.RowIsActive, p.LkProgram, lv1.Description as Program, 
		pr.DualGoal
	from projectrelated pr(nolock)
	join project p(nolock) on pr.RelProjectId = p.ProjectId
	join projectname pn(nolock) on pr.RelProjectId = pn.ProjectID
	join LookupValues lv(nolock) on pn.LkProjectName = lv.TypeId
	join  LookupValues lv1(nolock) on p.LkProgram = lv1.TypeId
	where pn.DefName = 1 and pr.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or pr.RowIsActive = @IsActiveOnly)
	order by pr.DateModified desc

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