Use FFV
go

truncate table VHCb.dbo.EnterprisePrimeProduct
go

insert into VHCb.dbo.EnterprisePrimeProduct([ProjectID], [OtherNames], [YrManageBus])
select ProjectId, EnvelopeName, 'ra'
from [dbo].[Viability Conversion #3] v
join VHCB.dbo.project p(nolock) on v.[Project #] = p.proj_num
go


select * from VHCb.dbo.EnterprisePrimeProduct
go