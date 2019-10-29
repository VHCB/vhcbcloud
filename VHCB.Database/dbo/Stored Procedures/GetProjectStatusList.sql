
create procedure dbo.GetProjectStatusList
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
begin transaction
--exec GetProjectStatusList 6588, 0
	begin try
	
	select ProjectStatusID, lv.Description as ProjectStatus, LKProjStatus,
		convert(varchar(10), StatusDate, 101) as StatusDate,
		ps.RowIsActive
	from ProjectStatus ps(nolock)
	join lookupvalues lv(nolock) on ps.LKProjStatus = lv.TypeID
	where ps.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or ps.RowIsActive = @IsActiveOnly)
	order by ps.DateModified desc

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