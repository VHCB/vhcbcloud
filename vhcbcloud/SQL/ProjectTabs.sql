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