CREATE procedure [dbo].[GetProjectsByFilter]
(
	@filter varchar(20)
)
as
Begin
	declare @recordId int
	select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 	
	if(CHARINDEX('-', @filter) > 0)
	begin
		select	distinct			
				top 35 CONVERT(varchar(20), p.Proj_num) as proj_num
		from Project p 
				join ProjectName pn on p.ProjectId = pn.ProjectID
				join ProjectApplicant pa on pa.ProjectId = p.ProjectId
				join LookupValues lpn on lpn.TypeID = pn.LkProjectname
				join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
				join AppName an on aan.AppNameID = an.appnameid
		where pn.DefName = 1 and lpn.LookupType = @recordId and p.Proj_num like @filter +'%'
		order by Proj_num asc
	end
	else 
	Begin
		select	distinct			
				top 35 CONVERT(varchar(20), p.Proj_num) as proj_num
		from Project p 
				join ProjectName pn on p.ProjectId = pn.ProjectID
				join ProjectApplicant pa on pa.ProjectId = p.ProjectId
				join LookupValues lpn on lpn.TypeID = pn.LkProjectname
				join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
				join AppName an on aan.AppNameID = an.appnameid
		where pn.DefName = 1 and lpn.LookupType = @recordId and 
		replace(p.proj_num, '-', '') like @filter+ '%'
		order by Proj_num asc
	end
	--select top 20 proj_num from project p where p.Proj_num like @filter +'%'
end