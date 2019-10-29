CREATE procedure GetLandUsePermit
(
	 @projectId int
)
as
 Begin
	--select af.UsePermit, af.Act250FarmId from Act250Farm af join Act250Projects ap on ap.Act250FarmId = af.Act250FarmId where ap.RowIsActive=1
	--and ap.projectid = @projectId
	select distinct af.UsePermit, af.Act250FarmId from Act250Farm af 
		join detail d on d.landusepermitid = af.Act250FarmID
		join Trans tr on tr.TransId = d.TransId
	where tr.ProjectID = @projectid
 end