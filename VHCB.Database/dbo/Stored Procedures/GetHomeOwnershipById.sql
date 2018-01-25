
create procedure dbo.GetHomeOwnershipById
(
	@HomeOwnershipID	int
) as
begin transaction

	begin try

	select HomeOwnershipID, ProjectId, AddressID, MH, Condo, SFD, RowIsActive 
	from HomeOwnership(nolock)
	where HomeOwnershipID = @HomeOwnershipID
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