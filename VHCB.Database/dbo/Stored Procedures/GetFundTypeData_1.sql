CREATE procedure [dbo].[GetFundTypeData]
(
	@IsActiveOnly	bit = true
)
as
begin
	select lkf.TypeId, lkf.Description, lkv.Description as source, lkf.RowIsActive 
	from lkfundtype  lkf 
	join LookupValues lkv on lkv.TypeID = lkf.LkSource
	where lkv.LookupType = 40 and (@IsActiveOnly = 0 or lkf.RowIsActive = @IsActiveOnly)
	order by Description 
end