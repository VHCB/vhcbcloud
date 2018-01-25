
CREATE procedure pcr_submit_items
(
	@ProjectCheckReqID	int, 
	@lkPCRItems int
)
as 
Begin
	insert into ProjectCheckReqItems (ProjectCheckReqID, LKCRItems, RowIsActive)
	values (@ProjectCheckReqID, @lkPCRItems, 1)
End