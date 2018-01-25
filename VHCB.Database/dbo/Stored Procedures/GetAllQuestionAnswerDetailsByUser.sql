
CREATE procedure GetAllQuestionAnswerDetailsByUser
(
@UserId int,
@YrQrtrId int,
@IsActive bit
)
as

Begin

-- exec GetAllQuestionAnswerDetailsByUser 3,1,1 

  SELECT  ACPM.ACPerformanceMasterID
		  ,'Q' +cast(ROW_NUMBER() OVER(ORDER BY ACPM.ACPerformanceMasterID ASC) as varchar(5)) +' - ' +ACPM.LabelDefinition as Question
		  ,ISNULL(ACPD.Response,'') AS Response
		  ,ACPD.IsCompleted
		  ,ACPM.ResultType
  FROM ACPerformanceMaster ACPM LEFT OUTER JOIN ACPerfData ACPD ON ACPM.ACPerformanceMasterId = ACPD.ACPerformanceMasterId AND ACPD.UserID = @userId and ACPD.RowIsActive = @IsActive
  WHERE ACPM.ACYrQtrID = @yrQrtrId  
end