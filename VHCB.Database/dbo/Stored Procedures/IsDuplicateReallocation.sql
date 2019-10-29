CREATE procedure IsDuplicateReallocation
(
	@FromProjectId int,
	@fromTransId int,
	@toTransId int 
)
as
Begin

	select 1 from ReallocateLink where FromProjectId =5624 and FromTransID = 257 and ToTransID = 257

End