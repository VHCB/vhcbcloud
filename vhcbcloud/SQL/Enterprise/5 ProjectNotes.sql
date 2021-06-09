use VHCB
go


delete from ProjectNotes where [ProjectNotesID] > 95
go

insert into ProjectNotes([ProjectId], [LkCategory], [UserId], [Date], [Notes])
select ProjectId, 29814 as [LkCategory], 12 as [UserId], getdate(),Notes
from dbo.Fundamentals_Final2
where ProjectId is not null and Notes is not null
go

select * from ProjectNotes
go

