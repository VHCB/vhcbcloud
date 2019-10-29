
create procedure GetProjectEventById
(
	@ProjectEventID int
)  
as
--exec GetProjectEventById 6588
begin

	select ProjectEventID, Prog, ProjectID, ApplicantID, EventID, SubEventID, Date, Note, UserID, RowIsActive
	from ProjectEvent (nolock)
	where ProjectEventID = @ProjectEventID
end