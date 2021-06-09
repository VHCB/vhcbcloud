use VHCB
go


begin tran

truncate table EnterpriseEvalStatusPt
go

--insert into EnterpriseEvalStatusPt([ProjectID], [StatusPt], [MSDate], [Comment])
--select ProjectId,  [Status Pt ID] as StatusPt, getdate() as MSDate, 
--case when [Eval#Comments] = 'NULL' THEN '' else [Eval#Comments] end
--from dbo.Fundamentals_Final2
--where ProjectId is not null --and projectid = 10053
--go


--alter table [Both Evals and SkillInfo] add ProjectId int
 
--update ev set ev.projectId = pv.Project_id
--from [Both Evals and SkillInfo] ev(nolock)
--join project_v pv(nolock) on pv.proj_num = ev.[Project #]


--begin tran

insert into EnterpriseEvalStatusPt(ProjectID, StatusPt, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, 
	LoanReq, LoanRec, LoanPend, GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName)
select ProjectId, [Statuspt TypeID], getdate(), [Comments], [leadplanadvisorexp], 
case when [planprocess ] = 'Yes' THEN 1 else 0 end [planprocess ], isnull(LoanReq, 0), isnull([LoanRec ], 0),
case when [LoanPend] = 'Pending' THEN 1 else 0 end [LoanPend], isnull([GrantReq], 0), isnull([GrantRec], 0),
case when isnull([GrantPend], '') = '' THEN 0 else 1 end [GrantPend], isnull([OtherReq ], 0),  isnull([OtherRec ], 0),
case when isnull([OtherPend], '') = '' THEN 0 else 1 end [OtherPend], [SharedOutcome], QuoteUse, 
SUBSTRING([QuoteName], 1, 25)
from [dbo].[Both Evals and SkillInfo] e(nolock)
where ProjectId is not null --and projectid = 10053
go

commit

select * from EnterpriseEvalStatusPt
go