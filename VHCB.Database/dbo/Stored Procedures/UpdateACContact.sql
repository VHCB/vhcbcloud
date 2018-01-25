
Create procedure UpdateACContact
(
	@fName varchar(20),
	@lName varchar(35),
	@contactId int
)
as

begin
	
	update Contact set Firstname = @fName, Lastname=@lName
	where ContactId = @contactId

end