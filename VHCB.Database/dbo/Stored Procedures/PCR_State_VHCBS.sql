
CREATE procedure PCR_State_VHCBS
as
begin
	select StateAcctnum
	from dbo.stateaccount sa(nolock)
	--where LkTransType = 241
end