CREATE procedure PCR_Questions
(
	@IsLegal bit = 0
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	--if(@IsLegal = 0)
	--	select TypeID, Description from  LkPCRQuestions where def = 0 and RowIsActive = 1
	--else
	--begin
	--	select TypeID, Description from  LkPCRQuestions where def = 0 and RowIsActive = 1
	--	union 
	--	select TypeID, Description from  LkPCRQuestions where TypeID = 7

	--end

	if(@IsLegal = 0)
		select TypeID, Description from  LkPCRQuestions where def = 1 and RowIsActive = 1
	else
	begin
		select TypeID, Description from  LkPCRQuestions where def = 1 and RowIsActive = 1
				union 
		select TypeID, Description from  LkPCRQuestions where TypeID = 7
	end
end