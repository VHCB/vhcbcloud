
create procedure [dbo].UpdateQuestions
(
	@ACPerformanceMasterID int,
	@QuestionNum int,
	@Question nvarchar(350),
	@ResultType int,
	@IsActive bit
)
as
begin transaction

	begin try

	update ACPerformanceMaster
		set QuestionNum = @QuestionNum,
		LabelDefinition = @Question,
		ResultType = @ResultType,
		RowIsActive = @IsActive,
		DateModified = getdate()
	from Address
	where ACPerformanceMasterID= @ACPerformanceMasterID
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