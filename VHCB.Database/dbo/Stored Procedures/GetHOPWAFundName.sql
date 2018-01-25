create procedure GetHOPWAFundName
(
	@RowIsActive	bit = true
)
--exec GetFundName 0
as
begin
	select fundid, account, name from Fund 
	where  (@RowIsActive = 0 or RowIsActive = @RowIsActive) and name like 'HOPWA%'
	order by name asc 
end