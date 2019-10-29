
create procedure UpdateProjectDesc
(
	@ProjectId		int,
	@Desc	nvarchar(max)
)  
as
--exec GetProjectDesc 1, null
begin
	
	update Project set Descrip = @Desc  where ProjectId = @ProjectId
end