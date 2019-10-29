
CREATE procedure GetAvailableTransTypesPerProjFundId
(
	@fundId int,
	@projectid int
)
as
Begin
	select distinct projectid,fundid,account,typeid,fundtype,name, proj_num,projectname,sum(detail) as availFunds
	from vw_FinancialDetailSummary where fundid = @fundId and projectid = @projectid
	group by projectid,fundid,account,typeid,fundtype,name, proj_num,projectname
end