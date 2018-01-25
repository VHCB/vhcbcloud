 CREATE procedure GetAllLandUsePermit
 (
	 @projectId int
 )
as
begin
	
	declare @lkprogram int 
	set @lkprogram = (select LkProgram from Project where ProjectId = @projectid)

	select distinct af.UsePermit, af.Act250FarmId, * from Act250Farm af 
	left join Act250Projects ap on ap.Act250FarmID = af.Act250FarmID 	
	where af.RowIsActive=1 and af.type = @lkprogram
end