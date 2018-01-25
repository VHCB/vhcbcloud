
CREATE procedure dbo.DeleteYearQuarterId
(
	@yrQrtrId int
)

as
Begin
begin transaction

 begin try
   Delete from ACYrQtr where ACYrQtrID = @yrQrtrId
   Delete from ACPerformanceMaster where ACYrQtrID = @yrQrtrId
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