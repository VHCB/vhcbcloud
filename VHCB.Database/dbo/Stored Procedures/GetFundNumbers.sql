
create procedure GetFundNumbers
(
	@RowIsActive bit = true
)
--exec GetFundNumbers 0
as
Begin
	select fundid, account, name 
	from Fund 
	where  (@RowIsActive = 0 or RowIsActive = @RowIsActive)
	order by account asc
End