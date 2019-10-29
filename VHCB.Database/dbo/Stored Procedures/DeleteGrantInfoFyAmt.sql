
CREATE procedure DeleteGrantInfoFyAmt
(
	@GrantInfoFy int
)
as
begin
	Delete from GrantinfoFYAmt where GrantInfoFY = @GrantInfoFy
End