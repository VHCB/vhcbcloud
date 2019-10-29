
create procedure GetSurfaceWatersList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetSurfaceWatersList 1, 1
begin
	select  psw.SurfaceWatersID, psw.ProjectID, psw.LKWaterShed, lv.Description as watershed, 
		psw.SubWaterShed, psw.LKWaterBody, lv1.Description as waterbody, psw.FrontageFeet, psw.OtherWater, psw.RowIsActive
	from ProjectSurfaceWaters psw(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = psw.LKWaterShed
	left join LookupValues lv1(nolock) on lv1.TypeID = psw.LKWaterBody
	where psw.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or psw.RowIsActive = @IsActiveOnly)
	order by psw.DateModified desc
end