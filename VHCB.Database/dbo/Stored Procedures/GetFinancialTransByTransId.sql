
CREATE procedure GetFinancialTransByTransId
(
	@transId int,
	@activeOnly int
)
as
Begin

	if  (@activeOnly=1)
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId				
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.RowIsActive= @activeOnly 	and tr.TransId = @transId and lv.TypeID= 261
	end
	else
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId			
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.TransId = @transId and lv.TypeID= 261
	End
end