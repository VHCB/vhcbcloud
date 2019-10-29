

CREATE procedure PCR_Update_Questions_For_Approval
(
	@ProjectCheckReqQuestionid	int,
	@Approved bit,
	@StaffID int
)
as
begin
	update ProjectCheckReqQuestions set Approved = @Approved, Date = CONVERT(char(10), GetDate(),126), StaffID = @StaffID
	from ProjectCheckReqQuestions
	where ProjectCheckReqQuestionid = @ProjectCheckReqQuestionid
end