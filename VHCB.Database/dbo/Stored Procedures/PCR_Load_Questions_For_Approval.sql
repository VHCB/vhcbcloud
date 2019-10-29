
CREATE procedure PCR_Load_Questions_For_Approval
(
	@ProjectCheckReqID	int
)
as
begin
	select pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, pcrq.Approved, pcrq.Date, pcrq.StaffID 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	where ProjectCheckReqID = @ProjectCheckReqID
end