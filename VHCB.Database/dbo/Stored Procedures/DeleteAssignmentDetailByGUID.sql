CREATE procedure DeleteAssignmentDetailByGUID
(
	@DetailGuId varchar(100)
)
as
Begin

	declare @FromTransId int

	select @FromTransId = TransId from Detail(nolock) where DetailGuId = @DetailGuId and amount < 0

	delete from detail where TransId = @FromTransId
	delete from trans where TransId = @FromTransId

	delete from detail where TransId in(select ToTransID from TransAssign(nolock) where TransID = @FromTransId)
	delete from trans where TransId in(select ToTransID from TransAssign(nolock) where TransID = @FromTransId)

	delete from TransAssign where TransId = @FromTransId
End