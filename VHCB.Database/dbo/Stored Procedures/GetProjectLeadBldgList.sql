
create procedure GetProjectLeadBldgList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadBldgList 6625, 1
	select LeadBldgID, plb.ProjectID, Building, plb.AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
		HistStatus, AppendA, plb.RowIsActive,
		isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from ProjectLeadBldg plb(nolock)
	join Address a(nolock) on a.Addressid = plb.AddressId
	where plb.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plb.RowIsActive = @IsActiveOnly)
	order by plb.DateModified desc
end