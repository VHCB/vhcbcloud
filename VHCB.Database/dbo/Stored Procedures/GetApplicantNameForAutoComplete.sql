
create procedure [dbo].[GetApplicantNameForAutoComplete]
(
	@applicantNamePrefix varchar(75)	
)
as 
--exec GetApplicantNameForAutoComplete 'ram'
Begin
	select AppNameId, applicantname from appname  where applicantname like @applicantNamePrefix + '%'  order by applicantname 	
end