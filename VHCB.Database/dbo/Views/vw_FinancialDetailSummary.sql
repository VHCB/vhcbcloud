CREATE view vw_FinancialDetailSummary
as
	select  p.projectid, 
				det.FundId,f.account,
				det.lktranstype, 
				ttv.typeid,				
				ttv.description as FundType,
				case 
					when tr.LkTransaction = 236 then 'Cash Disbursement'
					when tr.LkTransaction = 237 then 'Cash Refund'
					when tr.LkTransaction = 238 then 'Board Commitment'
					when tr.LkTransaction = 239 then 'Board Decommitment'
					when tr.LkTransaction = 240 then 'Board Reallocation'
				end as 'Transaction',
				f.name,
				p.proj_num, 
				lv.Description as projectname,				
				tr.ProjectCheckReqID,
				f.abbrv,
				 case when tr.LkTransaction= 236 then  -(det.Amount) else det.Amount end as   detail, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 			 
				tr.date as TransDate,
				det.LandUsePermitID
				from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId		
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238, 239, 240, 236, 237, 26552)and pn.DefName = 1 
		and tr.RowIsActive = 1 and det.RowIsActive = 1