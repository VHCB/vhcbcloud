
create procedure dbo.GetHouseUses
(
	@UsesDescription varchar(10)
) as
begin transaction
-- exec GetHouseUses 'VHCB'
	begin try

	if(@UsesDescription = 'vhcb')
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 114 
			and description like 'vhcb%'
	end
	else
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 114 
			and description not like 'vhcb%'

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