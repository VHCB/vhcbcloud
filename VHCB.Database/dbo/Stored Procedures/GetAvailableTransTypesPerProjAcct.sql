
CREATE procedure GetAvailableTransTypesPerProjAcct
(
	@account varchar(20),
	@projectid int
)
as
Begin
	select distinct projectid,fundid,account,typeid,fundtype,name, proj_num,projectname,sum(detail) as availFunds
	from vw_FinancialDetailSummary where account = @account and projectid = @projectid
	group by projectid,fundid,account,typeid,fundtype,name, proj_num,projectname
end