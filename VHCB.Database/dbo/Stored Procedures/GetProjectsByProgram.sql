
CREATE procedure GetProjectsByProgram
(
	@progId int,
	@projId int
)
as
begin
	select projectid, lkprogram from Project where RowIsActive = 1 and lkprogram = @progId and projectid = @projId
end