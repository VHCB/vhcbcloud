CREATE procedure PCR_Submit_Questions
(
	@ProjectCheckReqID	int, 
	@LkPCRQuestionsID	int,
	@staffId int
)
as
begin

	if not exists (select ProjectCheckReqID from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID and LkPCRQuestionsID = @LkPCRQuestionsID)
	begin
		insert into ProjectCheckReqQuestions(ProjectCheckReqID, LkPCRQuestionsID,  Date, StaffID)
		values(@ProjectCheckReqID, @LkPCRQuestionsID, GETDATE(), @staffId)
	end
end