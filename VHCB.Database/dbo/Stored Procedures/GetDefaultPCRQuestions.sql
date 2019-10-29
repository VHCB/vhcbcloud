CREATE procedure GetDefaultPCRQuestions
(
@IsLegal bit = 0,
@ProjectCheckReqID	int
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	select ROW_NUMBER() OVER (ORDER BY ProjectCheckReqQuestionID) rowNumber, 
	pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, ui.userid,
	case when pcrq.Approved = 1 then 'Yes'
		else 'No' end as Approved , pcrq.Approved as chkApproved, pcrq.Date, --ui.fname+', '+ui.Lname   as staffid ,
	case when pcrq.Approved != 1 then ''
		else ui.fname+' '+ui.Lname  end as staffid 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	left join UserInfo ui on pcrq.StaffID = ui.UserId
	where q.RowIsActive = 1 and ProjectCheckReqID = @ProjectCheckReqID
	order by qorder
end