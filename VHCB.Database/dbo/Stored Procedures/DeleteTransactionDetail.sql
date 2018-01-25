create procedure DeleteTransactionDetail
(
	@detailId int
)
as
Begin
	Delete from Detail where DetailID = @detailId
End