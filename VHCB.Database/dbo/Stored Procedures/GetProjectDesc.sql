
create procedure GetProjectDesc
(
	@ProjectId		int,
	@ProjectDesc	nvarchar(max) output
)  
as
--exec GetProjectDesc 1, null
begin
	
	select @ProjectDesc = Descrip from Project where ProjectId = @ProjectId
end