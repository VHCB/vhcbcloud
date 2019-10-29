

CREATE procedure GetCommittedFundPerProject
(
	@proj_num varchar(20)
)
as
Begin
	select distinct projectid, proj_num,projectname, sum(detail) as availFunds  from vw_FinancialDetailSummary where proj_num = @proj_num
	group by projectid,proj_num,projectname
end