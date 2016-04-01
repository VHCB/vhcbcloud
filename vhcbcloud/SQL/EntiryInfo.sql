--select * from applicant (nolock) order by DateModified desc
declare @ApplicantId int
declare @AppNameID int
declare @ContactId int
declare @AddressId int

set @ApplicantId = 1047

select * from applicant(nolock) where ApplicantId = @ApplicantId
select * from applicantappname(nolock) where ApplicantId = @ApplicantId
select @AppNameID = AppNameID from applicantappname(nolock) where ApplicantId = @ApplicantId
select * from appname(nolock) where AppNameID = @AppNameID	

select * from applicantcontact(nolock) where ApplicantId = @ApplicantId
select @ContactId = ContactId from applicantcontact(nolock) where ApplicantId = @ApplicantId
select * from contact(nolock) where ContactId = @ContactId

select * from ApplicantAddress(nolock) where ApplicantId = @ApplicantId
select @AddressId = AddressId from ApplicantAddress(nolock) where ApplicantId = @ApplicantId
select * from Address(nolock) where AddressId = @AddressId
		