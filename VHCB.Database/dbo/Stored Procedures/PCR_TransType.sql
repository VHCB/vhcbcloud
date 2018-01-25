

CREATE procedure PCR_TransType
as
begin
	select distinct v.Description, v.typeid from LkTransType_v v(nolock)
	join Detail d(nolock) on v.typeid = d.LkTransType
	order by v.typeid
end