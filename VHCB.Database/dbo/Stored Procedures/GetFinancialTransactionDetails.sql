CREATE procedure GetFinancialTransactionDetails
(
	@project_id							int,
	@financial_transaction_action_id	int,
	@tran_start_date					datetime,
	@tran_end_date						datetime
)
as
--exec GetFinancialTransactionDetails 6637, 238, '05/08/2017', '05/16/2017' 
--exec GetFinancialTransactionDetails 5615, 239, '01/01/2016', '02/01/2016'--DeCommit
--exec GetFinancialTransactionDetails 5615, -1, '01/01/2016', '02/01/2016'--All
--exec GetFinancialTransactionDetails -1, -1, '01/01/2016', '02/07/2016'--All
begin

	if ( @financial_transaction_action_id = 236)
	begin
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, (select crdate from projectcheckreq where ProjectCheckReqID = trans.ProjectCheckReqID  and projectid = @project_id) as TransactionDate, trans.TransAmt, 
		v.description as LkTransactionDesc--, trans.LkTransaction, v.*
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		where trans.TransId in (
			select t.TransId from (
			select case when ((select count(*) from ProjectCheckReqQuestions where ProjectCheckReqID = pcr.ProjectCheckReqID and Approved =0)>0) then 
			 0 else  trans.TransId end as TransId
			 , trans.TransAmt
			 , sum(det.Amount) amount, trans.TransAmt - sum(det.Amount) bal
				from Trans trans(nolock)
					join detail det(nolock) on trans.TransId = det.TransId
					 join ProjectCheckReq pcr on pcr.ProjectCheckReqID = trans.ProjectCheckReqID					 
				where pcr.CRDate >= @tran_start_date 
					and pcr.CRDate <= @tran_end_date 
					and trans.LKStatus = 261 and trans.RowIsActive=1  
									and (trans.projectid = @project_id or (@project_id = -1 and trans.projectid is not null))
					and (trans.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and trans.LkTransaction is not null))
					
			group by trans.TransId, trans.TransAmt, pcr.projectcheckreqid)t
			where t.bal = 0 and pv.defname = 1  
		) order by pv.proj_num
	end
	else 
	begin
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, trans.Date as TransactionDate, trans.TransAmt, 
			v.description as LkTransactionDesc, --, trans.LkTransaction, v.*
			ui.Fname + ' ' + ui.Lname as UserName, trans.adjust
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		left join userinfo ui(nolock) on ui.UserId = trans.UserId
		where trans.Date >= @tran_start_date 
			and trans. Date <= @tran_end_date  
			and (trans.projectid = @project_id or (@project_id = -1 and trans.projectid is not null))
			and (trans.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and trans.LkTransaction is not null))
			and trans.LKStatus = 261 
			and trans.LkTransaction not in(236, 26552)
			and trans.RowIsActive = 1 
			and trans.Balanced = 1 
			and pv.defname = 1  
		union
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, trans.Date as TransactionDate, trans.TransAmt, 
			v.description as LkTransactionDesc, --, trans.LkTransaction, v.*
			ui.Fname + ' ' + ui.Lname as UserName, trans.adjust
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		left join userinfo ui(nolock) on ui.UserId = trans.UserId
		where trans.Date >= @tran_start_date 
			and trans. Date <= @tran_end_date  
			and (trans.projectid = @project_id or (@project_id = -1 and trans.projectid is not null))
			and (trans.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and trans.LkTransaction is not null))
			and trans.LKStatus = 261 
			and trans.LkTransaction = 236 and trans.Adjust = 1
			and trans.RowIsActive = 1 
			and trans.Balanced = 1 
			and pv.defname = 1  
		union
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, trans.Date as TransactionDate, trans.ReallAssignAmt, 
		v.description as LkTransactionDesc, --, trans.LkTransaction, v.*
		ui.Fname + ' ' + ui.Lname as UserName, trans.adjust
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		left join userinfo ui(nolock) on ui.UserId = trans.UserId
		where trans.TransId in(
		select distinct ta.TransID
		from TransAssign ta(nolock)
		join Trans t(nolock) on ta.TransID = t.TransId
		where  t.Date >= @tran_start_date 
			and t. Date <= @tran_end_date 
			and (t.projectid = @project_id or (@project_id = -1 and t.projectid is not null))
			and (t.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and t.LkTransaction is not null))
			and t.LKStatus = 261 
			and t.RowIsActive = 1 
			and t.Balanced = 1 
			)
			and pv.defname = 1 

		--select t.TransId from (
		--select trans.TransId as TransId, trans.TransAmt,
		--			sum(det.Amount) amount, trans.TransAmt - sum(det.Amount) bal
		--		from Trans trans(nolock)
		--			join detail det(nolock) on trans.TransId = det.TransId
		--		where trans.Date >= '01/01/2016' 
		--			and trans. Date <= '02/07/2016'  
		--			and trans.LKStatus = 261
		--			and trans.projectid is not null
		--			and trans.LkTransaction is not null
		--	group by trans.TransId, trans.TransAmt)t
		--	where t.bal = 0

	end
end