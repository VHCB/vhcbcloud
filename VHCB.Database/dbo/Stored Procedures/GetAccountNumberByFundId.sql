CREATE procedure GetAccountNumberByFundId
 (
	@fundid		int,
	@account	nvarchar(20) output
 )
as
begin
	--exec GetAccountNumberByFundId 143, ''
	select @account = account from fund where fundid = @fundid
	
end