
create procedure dbo.GetApplicantAppRole
(
	@AppNameId		int
) as
begin transaction
--exec GetApplicantAppRole 416
begin try
	declare @AppRole varchar(5)
	set @AppRole = '';
	select @AppRole =  isnull(a.AppRole, '')
	from applicantappname aan(nolock) 
	join appname an(nolock) on aan.appnameid = an.appnameid
	join applicant a(nolock) on a.applicantid = aan.applicantid
	where aan.AppNameID =  @AppNameId

	select @AppRole as AppRole

end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;