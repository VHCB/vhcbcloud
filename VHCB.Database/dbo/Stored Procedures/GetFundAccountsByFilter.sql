

CREATE procedure GetFundAccountsByFilter
( @filter varchar(20))
as
Begin
	select top 20 fundid, account, name from Fund 
	where  RowIsActive = 1 and account like  @filter +'%'
	order by account asc
End