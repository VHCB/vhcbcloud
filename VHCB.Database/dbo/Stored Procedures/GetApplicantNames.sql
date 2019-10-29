CREATE procedure GetApplicantNames
(
	@applicantName varchar(150)	
)
as 
Begin
	
	select distinct applicantname from AppName where applicantname like @applicantName +'%'
	order by applicantname

end