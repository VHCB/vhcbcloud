
CREATE PROCEDURE [dbo].[AddQuestionAnswers]
   ( @QuestionAnswerstble QuestionAnswers READONLY)
AS
--begin transaction
BEGIN
begin transaction
begin try

	DELETE acpd
	FROM acperfdata acpd
	INNER JOIN @QuestionAnswerstble qat
	  ON acpd.ACPerformanceMasterID =qat.ACPerformanceMasterID and acpd.UserID = qat.UserID
    insert into [dbo].acperfdata 
	select [ACPerformanceMasterID],
			[Response],
			[UserID],
			[IsCompleted],
			[RowIsActive],
			GETDATE() from @QuestionAnswerstble 
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
END