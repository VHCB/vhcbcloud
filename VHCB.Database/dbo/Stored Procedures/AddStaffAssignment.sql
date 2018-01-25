CREATE procedure [dbo].[AddStaffAssignment]
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
	--declare @fromPayeeapplicant int 
	--declare @ToPayeeApplicant int

	--select @fromPayeeapplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname
	--Where  a.finlegal=1 and p.ProjectId = @FromProjectId

	--select @ToPayeeApplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname		
	--Where  a.finlegal=1 and p.ProjectId = @ToProjectId

	--if(@toTransId >0)
	--	Begin
	--		insert into Detail (TransId, FundId, LkTransType, Amount)	values
	--				(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
	--		insert into ReallocateLink(fromprojectid, fromtransid, totransid) values
	--				(@FromProjectId, @fromTransId,@toTransId)
	--	End
	--Else
		
		DECLARE @guid1 AS uniqueidentifier
		SET @guid1 = NEWID()

		if (@FromProjectId != @ToProjectId)
		Begin
			
			if(@toTransId >0)
			Begin
				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)

				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@toTransId, @ToProjectId, @Tofundid , @Tofundtranstype, @Tofundamount, @guid1)
			end
			else
			begin

				--set @Fromfundamount = @Fromfundamount -@Tofundamount

				insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt, UserID)
					values (@FromProjectId, @transDate, 0, 26552, 261, -@Fromfundamount, @UserId) -- 26552 Board Assignment, 261 Pending
				set @fromTransId = @@IDENTITY;
	
				--insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt)
				--	values (@ToProjectId, @transDate, 0, 26552, 261, @Tofundamount)
				--set @toTransId = @@IDENTITY;
				
				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
					(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)

				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId) values
					(@fromTransId, @ToProjectId, @Tofundid , @Tofundtranstype, @Tofundamount, @guid1)			
				
			end
		end
		else
		Begin

			if(@toTransId >0)
			Begin
				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)

				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@toTransId, @ToProjectId, @Tofundid , @Tofundtranstype, @Tofundamount, @guid1)
			end
			else
			begin			
				insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt, UserId)
					values (@FromProjectId, @transDate, 0, 26552, 261, -@Fromfundamount, @UserId) -- 26552 Board Assignment, 261 Pending

				set @fromTransId = @@IDENTITY;
				set @toTransId = @@IDENTITY;

				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@fromTransId, @FromProjectId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @guid1)

				insert into Detail (TransId, ProjectID, FundId, LkTransType, Amount, DetailGuId)	values
					(@fromTransId, @ToProjectId, @Tofundid , @Tofundtranstype, @Tofundamount, @guid1)
			end

		End

		--insert into ReallocateLink(fromprojectid, fromtransid, ToProjectId, totransid, ReallocateGUID) values
		--		(@FromProjectId, @fromTransId, @ToProjectId, @toTransId, @transGuid)
		

		Select @fromTransId as FromTransId, @toTransId as ToTransId
end