use VHCBsandbox
go

--select * from dbo.Final_Viab_Conversion
--751

insert into dbo.Project([Proj_num], [LkProjectType], [LkProgram])
select [Project #], 
[EntType Code],
148 as 'LkProgram'
from dbo.AdditionalProjectsFarmDups
go
