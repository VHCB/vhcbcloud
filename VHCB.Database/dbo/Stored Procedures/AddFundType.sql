

CREATE procedure AddFundType
(
	@lkSource int,
	@description varchar(100)
)
as
Begin
	insert into LkFundType(lksource, Description)
	values (@lkSource, @description)
end