CREATE procedure GetAvailableFundsPerProjAcctFundtype
(
	@account varchar(20),
	@projectid int,
	@fundtypeId int,
	@LandUsePermitID int
)
as
Begin
	select distinct projectid, fundid, account, typeid, fundtype, name, proj_num,projectname, sum(detail) as availFunds
	from vw_FinancialDetailSummary 
	where account = @account and projectid = @projectid and typeid = @fundtypeId and isnull(LandUsePermitID, '') = @LandUsePermitID
	group by projectid, fundid, account, typeid, fundtype, name, proj_num, projectname
end