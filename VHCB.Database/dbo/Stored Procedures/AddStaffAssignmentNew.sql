CREATE procedure [dbo].[AddStaffAssignmentNew]
(
	@FromProjectId int,
	@ToProjectId int,
	@transDate datetime,		

	@Fromfundid int,	
	@Fromfundtranstype int,
	@Fromfundamount money,

	@Tofundid int,	
	@Tofundtranstype int,
	@Tofundamount money,

	@fromTransId int = null,
	@toTransId int = null, 
	@transGuid varchar(50) = null,
	@UserId int = null
)
as
Begin	
		
		DECLARE @guid1 AS uniqueidentifier
		SET @guid1 = NEWID()


		if(isnull(@fromTransId, 0) = 0)
		Begin

			insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt, UserID)
			values (@FromProjectId, @transDate, 0, 26552, 261, -@Fromfundamount, @UserId) -- 26552 Board Assignment, 261 Pending
			
			set @fromTransId = @@IDENTITY;

			insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
			(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)


			insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt, UserID)
			values (@ToProjectId, @transDate, 0, 26552, 261, -@Tofundamount, @UserId) -- 26552 Board Assignment, 261 Pending

			set @toTransId = @@IDENTITY;

			insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
			(@toTransId, @ToProjectId, @Fromfundid , @Fromfundtranstype, @Tofundamount, @guid1)

		end
		else
		begin
			insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
			(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)

			insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt, UserID)
			values (@ToProjectId, @transDate, 0, 26552, 261, -@Tofundamount, @UserId) -- 26552 Board Assignment, 261 Pending

			set @toTransId = @@IDENTITY;

			insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
			(@toTransId, @ToProjectId, @Fromfundid , @Fromfundtranstype, @Tofundamount, @guid1)
		end


		--insert into ReallocateLink(fromprojectid, fromtransid, ToProjectId, totransid, ReallocateGUID) values
		--		(@FromProjectId, @fromTransId, @ToProjectId, @toTransId, @transGuid)
		
		insert into TransAssign(TransID, ToTransID)
		values (@fromTransId, @toTransId)

		Select @fromTransId as FromTransId, @toTransId as ToTransId
end