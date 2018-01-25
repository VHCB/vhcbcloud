create procedure ClearNODAndItems
(
	@ProjectCheckReqID	int
)
as
Begin
	delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID;
	delete from ProjectCheckReqItems where ProjectCheckReqID = @ProjectCheckReqID;
End