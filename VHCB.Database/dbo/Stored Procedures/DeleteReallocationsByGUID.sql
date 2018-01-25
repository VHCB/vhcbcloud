CREATE procedure DeleteReallocationsByGUID
(
	@reallocateGUID varchar(100)
)
as
Begin
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where ReallocateGUID = @reallocateGuid
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where ReallocateGUID = @reallocateGuid

	delete reallocatelink where reallocateguid = @reallocateGUID
	delete Detail where transid in (select distinct transid from @temp)
	delete Trans where transid in (select distinct transid from @temp)
End