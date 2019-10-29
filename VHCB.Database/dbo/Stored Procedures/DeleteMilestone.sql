create procedure dbo.DeleteMilestone  
(
	@ProjectEventID		int
)
as
begin
--exec DeleteMilestone 127

		delete pe
		from ProjectEvent pe(nolock)
		where ProjectEventID = @ProjectEventID
end