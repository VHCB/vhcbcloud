

CREATE procedure [dbo].[UpdateFundInfo]
(
	@fundId int, 
	@fAccount varchar(4), 
	@fName varchar(35), 
	@fAbbrv varchar(20), 
	@fFundsType int,
	@vHCBCode varchar(25), 
	@lkAcctMethod int, 
	@deptId varchar(12), 
	@drawDown bit
)
as
Begin
	update fund set account=@fAccount, name = @fName, abbrv=@fAbbrv, LkFundType = @fFundsType,
	VHCBCode = @vHCBCode, LkAcctMethod = @lkAcctMethod, DeptID = @deptId, Drawdown = @drawDown
	where fundid = @fundId
end