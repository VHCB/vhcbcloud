
create procedure GetAct250DevPayList  
(
	@Act250FarmID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250DevPayList 1, 1
	select Act250PayID, AmtRec, DateRec, RowIsActive
	from  Act250DevPay (nolock)
	where Act250FarmID = @Act250FarmID 
		and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
	order by DateModified desc
end