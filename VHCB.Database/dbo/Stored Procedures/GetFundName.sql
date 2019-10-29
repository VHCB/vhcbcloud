
CREATE procedure GetFundName
(
	@RowIsActive	bit = true
)
--exec GetFundName 0
as
begin
	select fundid, account, name from Fund 
	where  (@RowIsActive = 0 or RowIsActive = @RowIsActive)
	order by name asc 
end