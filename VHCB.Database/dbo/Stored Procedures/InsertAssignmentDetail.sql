CREATE procedure InsertAssignmentDetail
(
	@TransId int,
	@ProjectId int,		
	@Amount money
)
as
Begin	

	declare @guid1 AS uniqueidentifier
	declare @Fundid int
	declare @LKTransType int
	declare @FromProjectId int
	declare @toTransId int

	SET @guid1 = NEWID()

	select top 1 @FromProjectId = ProjectId
	from Trans where TransId = @TransId

	select top 1 @Fundid = FundId, @LKTransType = LKTransType
	from Detail where TransId = @TransId --and Amount > 0 

	insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
	(@TransId, @FromProjectId, @Fundid , @LKTransType, -@Amount, @guid1)

	insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt, UserID)
	values (@ProjectId, GETDATE(), 0, 26552, 261, -@Amount, 100) -- 26552 Board Assignment, 261 Pending

	set @toTransId = @@IDENTITY;

	insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
	(@toTransId, @ProjectId, @Fundid , @LKTransType, @Amount, @guid1)


	insert into TransAssign(TransID, ToTransID)
		values (@TransId, @toTransId)

	--insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
	--(@TransId, @FromProjectId, @Fundid , @LKTransType, -@Amount, @guid1)

	--insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
	--(@TransId, @ProjectId, @Fundid , @LKTransType, @Amount, @guid1)
end