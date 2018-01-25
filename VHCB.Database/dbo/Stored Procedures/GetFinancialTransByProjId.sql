CREATE procedure GetFinancialTransByProjId
(
	@projId int,
	@activeOnly int,
	@transType int
)
as
Begin
-- exec GetFinancialTransByProjId 6622, 1

	if  (@activeOnly=1)
	Begin
		if(@transType = 240) --Reallocation
		begin
			select tr.TransId,
				t.FromFundName,  t.FromTransType as FromFundtransType, t.FromTransTypeId, t.FromLandusePermitId,
				p.projectid, p.Proj_num, 
				tr.Date, format( - ISNULL(tr.ReallAssignAmt,0), 'N2') as TransAmt, tr.LkStatus, 
				lv.description, tr.PayeeApplicant, tr.LkTransaction 
			from Project p 		
				join Trans tr on tr.ProjectID = p.ProjectId				
				join LookupValues lv on lv.TypeID = tr.LkStatus
				join dbo.getReallocationFromFundDetails(@projId, @transType, 1) t on t.TransId = tr.TransId
			Where  tr.RowIsActive= @activeOnly 	and tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
			order by tr.date desc
		end
		ELSE
		begin
			select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction 
			from Project p 		
				join Trans tr on tr.ProjectID = p.ProjectId				
				join LookupValues lv on lv.TypeID = tr.LkStatus
			Where  tr.RowIsActive= @activeOnly 	and tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
			order by tr.date desc
		end
	end
	else
	Begin
		if(@transType = 240)
		begin
			select tr.TransId,
				t.FromFundName,  t.FromTransType as FromFundtransType, t.FromTransTypeId, t.FromLandusePermitId,
				p.projectid, p.Proj_num, 
				tr.Date, format( - ISNULL(tr.ReallAssignAmt,0), 'N2') as TransAmt, tr.LkStatus, 
				lv.description, tr.PayeeApplicant, tr.LkTransaction 
			from Project p 		
				join Trans tr on tr.ProjectID = p.ProjectId				
				join LookupValues lv on lv.TypeID = tr.LkStatus
				join dbo.getReallocationFromFundDetails(@projId, @transType, 1) t on t.TransId = tr.TransId
			Where  tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
			order by tr.date desc
		end
		ELSE
		BEGIN
			select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.TypeID ,lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
				join Trans tr on tr.ProjectID = p.ProjectId			
				join LookupValues lv on lv.TypeID = tr.LkStatus
			Where  tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
			order by tr.date desc
		End
	END
end