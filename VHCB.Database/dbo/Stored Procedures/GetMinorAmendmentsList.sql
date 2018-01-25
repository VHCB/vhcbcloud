
create procedure GetMinorAmendmentsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetMinorAmendmentsList 1, 1
begin 
	select  c.ConserveID, a.ConserveMinAmendID, a.LkConsMinAmend, lv.Description as amendment, 
		a.ReqDate, a.LkDisp, lv1.Description disposition, a.DispDate, a.RowIsActive,
		substring(a.Comments, 0, 25) Comments, 
		a.Comments as FullComments, 
		a.URL,
		CASE when isnull(a.URL, '') = '' then '' else 'Click here' end as URLText
	from Conserve c(nolock)
	join ConserveMinorAmend a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkConsMinAmend
	left join LookupValues lv1(nolock) on lv1.TypeID = a.LkDisp
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end