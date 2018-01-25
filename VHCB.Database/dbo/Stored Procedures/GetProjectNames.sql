
create procedure dbo.GetProjectNames
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
--GetProjectNames 6588
begin transaction

	begin try

	select TypeID, Description, 
		case isnull(pn.DefName, '') when '' then 'No' when 0 then 'No' else 'Yes' end DefName, pn.DefName as DefName1,
		lv.RowIsActive
	from LookupValues lv(nolock)
	join ProjectName pn(nolock) on lv.TypeID = pn.LkProjectname
	where pn.ProjectID = @ProjectId 
		and (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
	order by pn.DefName desc, pn.DateModified desc

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