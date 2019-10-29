
create procedure GetConserveEholderList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveEholderList 1, 1
begin
	select  c.ConserveID, a.ConserveEholderID,  a.ApplicantId, an.ApplicantName, a.RowIsActive
	from Conserve c(nolock)
	join ConserveEholder a(nolock) on c.ConserveID = a.ConserveID
	join applicantappname aan(nolock) on a.applicantid = aan.applicantid
	join appname an(nolock) on aan.appnameid = an.appnameid
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end