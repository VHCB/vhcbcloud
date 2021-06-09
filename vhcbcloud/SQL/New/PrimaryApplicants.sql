use vhcb
go

	DECLARE @Projectid int, @ApplicantName nvarchar(250)

	declare NewCursor Cursor for
	select ProjectID, SUBSTRING([Primary App-Entity], 0, Len([Primary App-Entity]) - 4) as ApplicantName
	from [FFVConvert].[dbo].[NewProject_December] v(nolock)
	join Project p(nolock) on p.Proj_num = v.[PROJECT NUMBER]
	--where [PROJECT NUMBER] in('2009-073-034', '2009-073-035', '2009-073-036')

	open NewCursor
	fetch next from NewCursor into @Projectid, @ApplicantName
	WHILE @@FETCH_STATUS = 0
	begin

	declare @ApplicantId int
	set @ApplicantId = 0

	select top 1 @ApplicantId = ApplicantId
	from appname apname(nolock)
	join applicantappname aapname(nolock) on aapname.AppNameID = apname.AppNameID
	where apname.Applicantname = @ApplicantName order by ApplicantId desc

	if(@ApplicantId <> 0)
	begin
		--select @Projectid, @ApplicantId, @ApplicantName
		insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal)
		select @Projectid, @ApplicantId, 358, 1, 1 
		--print @ApplicantId
	end
	FETCH NEXT FROM NewCursor INTO @Projectid, @ApplicantName
	END

Close NewCursor
deallocate NewCursor
go


