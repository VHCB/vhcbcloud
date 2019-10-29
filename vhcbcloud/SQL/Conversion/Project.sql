select * from PTproject
--6690
select* from Project where Proj_num  ='8387-300-074' order by 1
--7028

insert into Project(Proj_num)
select pt.number
from PTproject pt
left join Project p on p.Proj_num = pt.number
where p.ProjectId is null and isnull(pt.number, '') <> '' -- is not null

select 7028 - 6642
--386

select count(*) from Project p(nolock)
join PTproject pt(nolock) on p.Proj_num = pt.number
--6488

select * from PTproject(nolock) where CONSERV = 0 and HOUSE = 0
--17

--select count(*) 
update p set p.LkProgram = 144
from Project p(nolock)
join ptproject pt(nolock) on p.Proj_num = pt.NUMBER
where CONSERV = 1 and HOUSE = 1

select * from Project where LkProgram is null