use FFV
go


insert into VHCB.dbo.Project([Proj_num], [LkProjectType], [LkProgram])
select [Project #], 
case [EntType] when 'Farm' then 26851
when  'Food (non-farm)' then 26852
when 'Forest Products' then 26401
end as 'LkProjectType',
148 as 'LkProgram'
from [VW_Farminfo for conversion]
go
--946


