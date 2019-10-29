
create procedure GetTotalHousingUnits  
(
	@ProjectID		int
)
as
begin
--exec GetTotalHousingUnits 6588
	select isnull(TotalUnits, 0) TotalUnits from Housing(nolock) where projectid = @ProjectID
end