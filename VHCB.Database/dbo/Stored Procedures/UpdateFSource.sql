Create procedure UpdateFSource
(
	@fundId int,
	@fsName varchar(35)
	
)
as
Begin
	Update fund set name=@fsName where FundId = @fundId
end