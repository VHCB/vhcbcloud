create procedure DeletePageSecurity
(
	@pagesecurityid int
)
as
Begin
	Delete from UserPageSecurity where pagesecurityid = @pagesecurityid
End