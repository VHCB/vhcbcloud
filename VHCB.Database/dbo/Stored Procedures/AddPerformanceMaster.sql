
create procedure dbo.AddPerformanceMaster(
	@SourceYearQtrId		int,
	@DestinationYearQtrId int
) as
begin transaction

	begin try

	INSERT INTO ACPerformanceMaster
	SELECT @DestinationYearQtrId
	       ,QuestionNum
		   ,NumOrder
		   ,LabelDefinition
		   ,ResultType
		   ,RowIsActive
		   ,GETDATE()
	FROM ACPerformanceMaster 
	WHERE ACYrQtrID = @SourceYearQtrId
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