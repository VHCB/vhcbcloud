CREATE procedure UpdateFinancialTransactionStatus
(
	@transId int
	
)
as
--exec UpdateFinancialTransactionStatus 2958
begin
	
	declare @toProjId int
	declare @lkTrans int

	select @lkTrans = LkTransaction from trans where TransId = @transId
	
	--if (@lkTrans = 240)
	--Begin

	--	declare  @ProjIdTable table(projIds int)
	--	declare  @transIdTable table(transIds int)

	--	select @toProjId= toprojectid from reallocatelink where totransid = @transid

	--	insert into @ProjIdTable(projIds) select toprojectid from reallocatelink where fromprojectid = @toProjId
	--	insert into @transIdTable(transIds)  select fromtransid from reallocatelink where toprojectid in (select projids from @ProjIdTable)
	--	insert into @transIdTable(transIds)  select totransid from reallocatelink where toprojectid in (select projids from @ProjIdTable)
	

	--	update trans set LKStatus = 262		
	--	where TransId in (select distinct transIds from @transIdTable) 
	--end


	update trans set LKStatus = 262	where TransId = @transId

	if (@lkTrans = 26552)--Assignment
	Begin
		update trans set LKStatus = 262		
		where TransId in (select distinct ToTransId from TransAssign(nolock) where TransId = @transid) 
	end
end