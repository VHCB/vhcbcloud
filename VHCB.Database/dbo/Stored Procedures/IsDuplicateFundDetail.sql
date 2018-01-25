
CREATE procedure IsDuplicateFundDetail 
(
	@detailId int,
	@fundid int,	
	@fundtranstype int

)
as
Begin
	select * from Detail where FundId = @fundid and LkTransType = @fundtranstype and DetailID = @detailId
End