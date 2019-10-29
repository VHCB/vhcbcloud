
CREATE procedure GetManagerByProjId
(
	@projId int
)
as
begin
	select projectid, manager from Project where RowIsActive = 1 and projectid = @projId
end