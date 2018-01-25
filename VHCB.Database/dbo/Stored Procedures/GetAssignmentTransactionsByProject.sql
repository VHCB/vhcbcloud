CREATE procedure GetAssignmentTransactionsByProject
(
	@ProjectId int,
	@TransactionType int,
	@ActiveOnly int
)
as
Begin
	select tr.TransId,
		t.FromFundName,  t.FromTransType as FromFundtransType, t.FromLandusePermitId,
		p.projectid, p.Proj_num, 
		tr.Date, format( - ISNULL(tr.ReallAssignAmt,0), 'N2') as TransAmt, tr.LkStatus, 
		lv.description, tr.PayeeApplicant, tr.LkTransaction 
	from Project p 		
		join Trans tr on tr.ProjectID = p.ProjectId				
		join LookupValues lv on lv.TypeID = tr.LkStatus
		join dbo.getReallocationFromFundDetails(@ProjectId, @TransactionType, 1) t on t.TransId = tr.TransId
	Where  tr.ProjectID = @ProjectId and lv.TypeID= 261 and tr.LkTransaction = @TransactionType
	order by tr.TransId desc

end