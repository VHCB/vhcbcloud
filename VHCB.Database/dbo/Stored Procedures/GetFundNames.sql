

CREATE procedure [dbo].[GetFundNames]
as
Begin
	select fundid, account, name from Fund 
	where  RowIsActive = 1 
	order by name asc
End