select * from ptfund
--192
select * from ptfundtype order by [key]
--12
select *
from ptfund ptf(nolock)
join ptfundtype ptft(nolock) on ptf.ftypekey = ptft.[key]
--191

alter view ptfund_v as
select ptf.[key], ftypekey, account, name, abbrv, type, source, lkft.*
from ptfund ptf(nolock)
join ptfundtype ptft(nolock) on ptf.ftypekey = ptft.[key]
join LkFundType lkft(nolock) on lkft.Description  = ptft.type

--191

select * from ptfund_v
--191
select * from Fund 
go

truncate table Fund
go

insert into Fund(name, abbrv, LkFundType, account, FundKey)
select name, abbrv, TypeId, account, [key]
from ptfund_v

select *  
from Fund f(nolock)
join ptfund_v v(nolock) on f.name = v.name

