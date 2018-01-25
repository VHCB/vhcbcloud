
CREATE view projects_v as
	select p.ProjectId, Proj_num, lv.Description as ProjectName, LKProjectType, LKProgram, lv1.Description as programname,  a.Street# + ' ' + a.Address1 
	+ ' ' + a.Address2  as Address, a.Town + ' ' + a.village + ' ' +a.county + ' ' + a.Zip as FullAddress, a.County, a.Town, 
	an.AppNameID, an.Applicantname, pap.LkApplicantRole, isnull(pa.PrimaryAdd, 0) PrimaryAdd, 
	isnull(pn.Defname, 0) IsProjectDefName--,  * 
	from Project p(nolock)
	left join projectName pn(nolock) on p.projectid = pn.projectid --and pn.Defname = 1
	left join lookupvalues lv(nolock) on lv.Typeid = pn.LKProjectname
	left join ProjectAddress pa(nolock) on pa.projectId = p.projectId --and pa.PrimaryAdd = 1
	left join Address a(nolock) on a.addressid = pa.addressid
	left join ProjectApplicant pap(nolock) on pap.projectid = p.projectid
	left join applicantappname aan(nolock) on aan.ApplicantID = pap.applicantid
	left join appname an(nolock) on an.AppNameID = aan.AppNameID
	left join lookupvalues lv1(nolock) on lv1.TypeID = p.LkProgram
	--where pn.Defname = 1 and pa.RowIsActive = 1 --and pap.Defapp = 1
	--where Proj_num = '9999-999-991'