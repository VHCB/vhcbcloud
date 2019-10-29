
create procedure [dbo].GetQuestionAnswerList
(
	@ACYrQtrID int,
	@IsActive bit
)
as 
--exec GetQuestionAnswerList 1,1
Begin

	SELECT ACPerformanceMasterID
	      ,LabelDefinition
		  ,CASE ResultType
		    WHEN 1 THEN 'Text'
			WHEN 2 THEN 'Digits'
			END AS ResultType
		  ,RowIsActive
		  ,QuestionNum
	FROM ACPerformanceMaster (nolock)
	WHERE ACYrQtrID = @ACYrQtrID and RowIsActive = CASE @IsActive WHEN 1 THEN @IsActive
														          WHEN 0 THEN RowIsActive
																  END
	
end