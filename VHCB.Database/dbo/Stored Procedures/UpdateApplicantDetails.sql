
create procedure [dbo].UpdateApplicantDetails
(
	@ApplicantId int,
	@IsIndividual bit,
	@EntityType int,
	@FiscalYearEnd nvarchar(10),
	@Website nvarchar(150),
	@StateVendorId nvarchar(24),
	@PhoneType	int,
	@Phone	nchar(20),
	@ApplicantName varchar(120),

	@Prefix int = null,
	@Fname varchar(20) = null,
	@Lname	varchar(35) = null,
	@Suffix int = null,
	@Position int = null,
	@Title nvarchar(50) = null,
	@Email nvarchar(150) = null
)
as 
--exec UpdateApplicantDetails 417
Begin

	if (@isindividual = 1)
	begin
		update c set LkPrefix = @Prefix, Firstname = @Fname, Lastname = @Lname, LkSuffix = @Suffix, LkPosition =@Position, Title = @Title
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		where ac.ApplicantId = @ApplicantId

		set @ApplicantName = @lname +', '+ @fname
	end

	update applicant 
	set LkEntityType = @EntityType, FYend = @FiscalYearEnd, website = @Website, Stvendid = @StateVendorId, 
		LkPhoneType = @PhoneType, Phone = @Phone, email = @Email
	from applicant where  ApplicantId = @ApplicantId

	update an set an.Applicantname = @ApplicantName
	from applicant a(nolock) 
	join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
	join appname an(nolock) on aan.AppNameID = an.AppNameID
	where a.ApplicantId = @ApplicantId

end