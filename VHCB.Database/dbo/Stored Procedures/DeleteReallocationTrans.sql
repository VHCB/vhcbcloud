CREATE procedure DeleteReallocationTrans
(
	@transId int
)
as
Begin
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where FromTransID = @transId
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromTransID = @transId

	delete reallocatelink where FromTransID in (select transid from @temp)
	delete reallocatelink where ToTransID in (select transid from @temp)
	delete Detail where transid in (select  transid from @temp)
	delete Trans where transid in (select  transid from @temp)
End