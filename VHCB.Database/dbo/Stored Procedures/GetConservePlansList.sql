
create procedure GetConservePlansList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConservePlansList 1, 1 
begin 
	select  c.ConserveID, a.ConservePlanID, a.LKManagePlan, lv.Description as MangePlan, 
		a.DispDate, a.RowIsActive,
		substring(a.Comments, 0, 25) Comments, 
		a.Comments as FullComments, 
		a.URL,
		CASE when isnull(a.URL, '') = '' then '' else 'Click here' end as URLText
	from Conserve c(nolock)
	join ConservePlan a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LKManagePlan
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end