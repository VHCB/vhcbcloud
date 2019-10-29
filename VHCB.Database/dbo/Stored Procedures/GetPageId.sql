
create procedure dbo.GetPageId
(
	@PageName varchar(50),
	@PageId	  int output
)
as
begin transaction
--exec GetPageId 'ConservationSummary.aspx', null
	begin try
	
		select @PageId = ProgramTabID
		from ProgramTab 
		where PageName = @PageName

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