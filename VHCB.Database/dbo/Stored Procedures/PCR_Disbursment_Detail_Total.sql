CREATE procedure PCR_Disbursment_Detail_Total
(
	@ProjectCheckReqID int,
	@total		decimal (9,2)  output
)
as
begin

	set @total = (select isnull(sum(amount) , 0.00)
	from detail(nolock)
	where TransId = (select TransID from Trans where ProjectCheckReqID = @ProjectCheckReqID))

	select Round(@total, 2)
end