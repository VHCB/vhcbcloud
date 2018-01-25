
create procedure GetHomeOwnershipList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetHomeOwnershipList 6625, 1
	select ho.ProjectID, ho.HomeOwnershipID, 
	case isnull(ho.MH, '') when '' then 'No' when 0 then 'No' else 'Yes' end MH, 
	case isnull(ho.Condo, '') when '' then 'No' when 0 then 'No' else 'Yes' end Condo, 
	case isnull(ho.SFD, '') when '' then 'No' when 0 then 'No' else 'Yes' end SFD,  
	ho.RowIsActive,
		isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from HomeOwnership ho(nolock)
	join Address a(nolock) on a.Addressid = ho.AddressId
	where ho.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or ho.RowIsActive = @IsActiveOnly)
	order by ho.DateModified desc
end