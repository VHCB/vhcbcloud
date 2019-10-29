
CREATE procedure GetGranteeByProject
(
	@projectId int
)
as
Begin
	select p.projectid, 
		p.Proj_num, lv.Description, a.applicantid, an.Applicantname from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
		join Applicant a on a.ApplicantId = pa.ApplicantId	
		join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
		join AppName an on an.AppNameID = aan.AppNameID 
		join LookupValues lv on lv.TypeID = pa.LkApplicantRole		
	Where  pa.finlegal=1 and p.ProjectId = @projectId
	and pn.defname = 1 and lv.typeid = 358
End