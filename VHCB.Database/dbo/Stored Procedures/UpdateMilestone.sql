create procedure dbo.UpdateMilestone  
(
	@ProjectEventID		int,
	@RowIsActive		bit
)
as
begin
--exec UpdateMilestone 127, 1

		update ProjectEvent  set RowIsActive = @RowIsActive
		where ProjectEventID = @ProjectEventID
end