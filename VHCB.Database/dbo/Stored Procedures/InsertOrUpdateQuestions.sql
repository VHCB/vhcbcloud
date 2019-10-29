
create procedure [dbo].InsertOrUpdateQuestions
(
	@ACPerformanceMasterID int,
	@QuestionNum int,
	@Question nvarchar(350),
	@ResultType int,
	@IsActive bit,
	@IsUpdate bit,
	@ACYrQtrID int
)
as
begin transaction

	begin try

	if(@IsUpdate = 0)
	begin
		Insert into ACPerformanceMaster(ACYrQtrID,QuestionNum,LabelDefinition,ResultType,RowIsActive,DateModified)
		values (@ACYrQtrID,@QuestionNum,@Question,@ResultType,@IsActive,GETDATE())
	end
	else
	begin
	update ACPerformanceMaster
		set QuestionNum = @QuestionNum,
		LabelDefinition = @Question,
		ResultType = @ResultType,
		RowIsActive = @IsActive,
		DateModified = getdate()
	from Address
	where ACPerformanceMasterID= @ACPerformanceMasterID
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