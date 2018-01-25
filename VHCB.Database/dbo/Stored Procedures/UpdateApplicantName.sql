CREATE procedure [dbo].[UpdateApplicantName]
(
	@ApplId bigint,
	@ApplName nvarchar(60)
)
as
Begin
	declare @Individual bit

	select @Individual = Individual 
	from Applicant 
	where Applicantid = @ApplId

	update AppName
		set ApplicantName = @ApplName
	where appnameid = @ApplId

	if(@Individual = 1)
	begin
		declare @firstname varchar(50)
		declare @lastname varchar(50)

		if CHARINDEX(',', @ApplName) > 0
		begin
			select @firstname = rtrim(ltrim(SUBSTRING(@ApplName, 0, CHARINDEX(',', @ApplName)))),
			@lastname = rtrim(ltrim(SUBSTRING(@ApplName, CHARINDEX(',', @ApplName) + 1, len(@ApplName) - 1)))
		end
		else
		begin
			set @firstname = @ApplName
		end

		print @ApplName
		print @firstname
		print 'lastname:' + @lastname
		print len(@firstname)
		print len(@lastname)

		update c set c.Firstname =  @firstname, c.Lastname = isnull(@lastname, '')
		from contact c
		join ApplicantContact ac(nolock) on c.ContactID = ac.ContactID
		where ac.ApplicantID  = @ApplId
	end

end