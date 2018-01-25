
CREATE  procedure [dbo].[updateLookups]
(
	@typeId int,
	@description varchar(50),
	@lookupTypeid int,	
	@isActive bit,
	@isRequired bit,
	@Ordering int
)
as
--exec updatelookups 97, 'Prime soils', 272, 1, 1
begin transaction

	begin try
		update LookupValues set Description = @description, ordering = @Ordering, RowIsActive=@isActive, SubReq = @isRequired where TypeID = @typeId;
		--update LkLookups set  RowIsActive=@isActive, Ordered = @isOrdered  where RecordID = @lookupTypeid;
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