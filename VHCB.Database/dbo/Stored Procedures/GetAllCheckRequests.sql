CREATE procedure [dbo].[GetAllCheckRequests]
as
Begin
	select p.proj_num, pa.ProjectApplicantID,an.AppNameID, an.Applicantname, pcq.initdate from AppName an 
	join ApplicantAppName aan on aan.AppNameID = an.AppNameID
	join ProjectApplicant pa on pa.ApplicantId =  aan.ApplicantID
	join ProjectCheckReq pcq on pa.ProjectId = pcq.ProjectID
	join project p on p.projectid = pa.projectid
	where aan.DefName = 1 
	order by pcq.DateModified desc, an.Applicantname asc

End