CREATE procedure AddDefaultPCRQuestions
(
@IsLegal bit = 0,
@ProjectCheckReqID	int,
@staffId int
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7
if not exists (select ProjectCheckReqID from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID and
				 LkPCRQuestionsID in (select typeid from LkPCRQuestions where Def=1 and RowIsActive = 1 ))
Begin
	if(@IsLegal = 0)
		Begin

			Insert into ProjectCheckReqQuestions (ProjectCheckReqID, LkPCRQuestionsID, Date)
			 (select @ProjectCheckReqID, typeId, getdate() from LkPCRQuestions where Def= 1 and RowIsActive =1)

			
		End
	else
	begin

		Insert into ProjectCheckReqQuestions (ProjectCheckReqID, LkPCRQuestionsID, Date)
			 (select @ProjectCheckReqID, typeId, getdate() from LkPCRQuestions where Def= 1 and RowIsActive =1
			 union all
			 select @ProjectCheckReqID, typeId, getdate() from LkPCRQuestions where TypeID=7 and RowIsActive =1)
	end
end
end