
CREATE procedure [dbo].[GetFundAccounts]
as
Begin
	select fundid, account, name from Fund 
	where  RowIsActive = 1 
	order by account asc
End