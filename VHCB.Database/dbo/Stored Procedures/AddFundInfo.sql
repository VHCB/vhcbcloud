create procedure AddFundInfo
(
 @name varchar(35),
 @abbr varchar(20), 
 @lkFundTypeId int, 
 @acct varchar(4), 
 @vHCBCode varchar(25), 
 @lkAcctMethod int, 
 @deptId varchar(12), 
 @drawDown bit
)
as
Begin
	insert into Fund(name,abbrv,LkFundType,account,VHCBCode,LkAcctMethod, DeptID, Drawdown)
	values (@name,@abbr,@lkFundTypeId, @acct, @vHCBCode,@lkAcctMethod, @deptId, @drawDown)

End