
create procedure dbo.GetPrimaryApplicants
as
begin transaction
	begin try
	
		select distinct an.appnameid, an.ApplicantName
		from Appname an
		join ApplicantAppName aan on aan.appnameid = an.appnameid
		join ProjectApplicant pa(nolock) on aan.ApplicantID = pa.ApplicantId
		where pa.LkApplicantRole = 358
			and pa.RowIsActive = 1
			and aan.DefName = 1
		order by an.ApplicantName asc
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