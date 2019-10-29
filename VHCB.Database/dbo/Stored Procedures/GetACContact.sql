
CREATE procedure [dbo].[GetACContact]

as
set nocount on
begin
	select c.ContactId, c.Firstname, c.LastName, an.Applicantname
		from Contact c(nolock) join ACmembers acm on acm.ContactID = c.ContactId
		join ApplicantAppName aan on aan.ApplicantID = acm.ApplicantID
		join AppName an on aan.AppNameID = an.AppNameID
	
	 order by c.DateModified desc

end