
create procedure dbo.GetCurrentProjectApplicants
(
	@ProjectId		int
) as
begin transaction
--exec GetCurrentProjectApplicants 6588
	begin try

	select
		an.applicantname,
		aan.appnameid
	from ProjectApplicant pa(nolock)
	join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
	join appname an(nolock) on aan.appnameid = an.appnameid
	where pa.ProjectId = @ProjectId and pa.RowIsActive =1
	order by an.applicantname
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