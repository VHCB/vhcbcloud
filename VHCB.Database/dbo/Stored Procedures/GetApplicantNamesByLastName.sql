CREATE procedure GetApplicantNamesByLastName
(
	@applicantLastName varchar(150)	
)
as 
Begin
	
	select distinct LastName from Contact where Lastname like @applicantLastName +'%'
	order by LastName

end