CREATE procedure GetProjectsByFinalizedStatus

as
Begin
	declare @recordId int
	select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
	select	distinct
			lpn.TypeID, 
			p.projectid, 
			lpn.Description,
			pn.DefName, 
			p.Proj_num, 
			pn.LkProjectname
	from Project p 
			join ProjectName pn on p.ProjectId = pn.ProjectID
			join ProjectApplicant pa on pa.ProjectId = p.ProjectId
			join LookupValues lpn on lpn.TypeID = pn.LkProjectname
			join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
			join AppName an on aan.AppNameID = an.appnameid
	where pn.DefName = 1 and lpn.LookupType = @recordId and p.ProjectId in (select distinct ProjectID from trans where LkStatus = 262)-- Finalyzed status
	order by  p.Proj_num asc

end