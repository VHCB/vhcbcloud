
--exec GetQuestionsByPCRID 66
create procedure GetQuestionsByPCRID
(
	@ProjectCheckReqId int
)
as
begin
	select ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID from ProjectCheckReqQuestions(nolock)  where ProjectCheckReqID = @ProjectCheckReqID
end