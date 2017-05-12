use VHCBSandbox
go

alter procedure PCR_Projects
as
begin
	select project_id, proj_num, project_name,  convert(varchar(25), project_id) +'|' + project_name as project_id_name
	from project_v 
	where DefName = 1
	order by proj_num
end
go

alter procedure PCR_Dates
as
begin
	select distinct convert(varchar(10), InitDate) as Date  from [dbo].[ProjectCheckReq]
	union all
	select distinct convert(varchar(10), Date) as Date from [dbo].[Trans]
	order by Date
end
go

alter procedure PCR_ApplicantName
(
	@ProjectID int
)
as
begin

	select an.Applicantname 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantID = a.ApplicantID
	where aan.DefName = 1 and pa.LkApplicantRole=358 and projectID = @ProjectID
	order by an.Applicantname
end
go

alter procedure PCR_Payee
as
begin
	select an.Applicantname, a.ApplicantId
	from applicant a(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on a.applicantid = aan.applicantid
	join [dbo].[AppName] an(nolock) on aan.AppNameID = an.AppNameID
	where a.FinLegal = 1
	order by an.Applicantname
end
go


alter procedure PCR_Program
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkProgram')
		and RowIsActive = 1
	order by TypeID
end
go

alter procedure PCR_MatchingGrant
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = 73
		and RowIsActive = 1
	order by TypeID
end
go

alter procedure PCR_FundName_Commitments
as
begin
	select distinct name, f.FundId from fund f(nolock)
	join Detail d(nolock) on d.FundId = f.FundId
	join trans tr (nolock) on tr.TransId = d.TransId
	where tr.LkTransaction = 238
	order by f.FundId
end
go

alter procedure PCR_TransType
as
begin
	select distinct v.Description, v.typeid from LkTransType_v v(nolock)
	join Detail d(nolock) on v.typeid = d.LkTransType
	order by v.typeid
end
go

alter procedure PCR_State_VHCBS
as
begin
	select StateAcctnum
	from dbo.stateaccount sa(nolock)
	--where LkTransType = 241
end
go

alter procedure PCR_Trans_Detail_Submit
(
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money
)
as
begin

	insert into Detail (TransId, FundId, LkTransType, Amount)	values
		(@transid, @fundid , @fundtranstype, @fundamount)

end
go

alter procedure PCR_Trans_Detail_Load
(
	@transid int
)
as
begin
Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
			d.LkTransType, t.LkTransaction, StateAcctnum +' - '+ isnull(f.DeptID, '') +' - '+ isnull(f.VHCBCode, '') as StateVHCBNos
from Fund f 
	join Detail d on d.FundId = f.FundId
	join Trans t on t.TransId = d.TransId
	join LookupValues lv on lv.TypeID = d.LkTransType
	left join stateaccount sa(nolock) on sa.LkTransType = d.LkTransType
Where     f.RowIsActive = 1 --and t.LkTransaction = @commitmentType
		and t.TransId = @transid 
end
go

alter procedure PCR_NOD_Load
as
begin
	select typeid, LookupType, Description 
	from LookupValues(nolock)
	where LookupType = (select RecordID from LkLookups where tablename = 'LkNOD')
		and RowIsActive = 1
end
go

alter procedure PCR_Questions
(
	@IsLegal bit = 0
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	if(@IsLegal = 0)
		select TypeID, Description from  LkPCRQuestions where def = 0 and RowIsActive = 1
	else
	begin
		select TypeID, Description from  LkPCRQuestions where def = 0 and RowIsActive = 1
		union all
		select TypeID, Description from  LkPCRQuestions where TypeID = 7

	end
end
go


alter procedure PCR_Submit_Questions
(
	@ProjectCheckReqID	int, 
	@LkPCRQuestionsID	int
)
as
begin

	if not exists (select ProjectCheckReqID from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID and LkPCRQuestionsID = @LkPCRQuestionsID)
	begin
		insert into ProjectCheckReqQuestions(ProjectCheckReqID, LkPCRQuestionsID)
		values(@ProjectCheckReqID, @LkPCRQuestionsID)
	end
end
go

alter procedure PCR_Load_Questions_For_Approval
(
	@ProjectCheckReqID	int
)
as
begin
	select pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, pcrq.Approved, pcrq.Date, pcrq.StaffID 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	where ProjectCheckReqID = @ProjectCheckReqID
end
go


alter procedure PCR_Update_Questions_For_Approval
(
	@ProjectCheckReqQuestionid	int,
	@Approved bit,
	@StaffID int
)
as
begin
	update ProjectCheckReqQuestions set Approved = @Approved, Date = CONVERT(char(10), GetDate(),126), StaffID = @StaffID
	from ProjectCheckReqQuestions
	where ProjectCheckReqQuestionid = @ProjectCheckReqQuestionid
end
go


alter procedure GetExistingPCR
as
Begin
	select pcr.ProjectCheckReqId, CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	join LookupValues lv on lv.TypeID = t.LkStatus
	where pv.defname = 1
	order by pcr.ProjectCheckReqId desc
End
go


alter procedure GetPCRDataById
(
	@ProjectCheckReqID	int
)
as
begin
	select pcr.ProjectCheckReqId, t.transid, pcr.ProjectID, pv.project_name, pcr.InitDate, pcr.LegalReview, t.TransAmt, an.Applicantname as Payee
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	where pcr.ProjectCheckReqId = @ProjectCheckReqID
	order by pcr.ProjectCheckReqId desc

end
go


alter procedure GetPayeeNameByProjectId
(
	@ProjectID int
)
as
begin

	select an.Applicantname, p.LkProgram 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantID = a.ApplicantID
	join project p on p.projectid = pa.ProjectId
	join ProjectName pn(nolock) on p.ProjectId = pn.ProjectID
	where pa.finlegal=1 and pn.defname=1 and pa.projectID = @ProjectID
	order by an.Applicantname
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetDefaultPCRQuestions]') and type in (N'P', N'PC'))
drop procedure [dbo].GetDefaultPCRQuestions 
go

CREATE procedure GetDefaultPCRQuestions
(
@IsLegal bit = 0,
@ProjectCheckReqID	int
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	select pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, ui.userid,
	case when pcrq.Approved = 1 then 'Yes'
		else 'No' end as Approved , pcrq.Approved as chkApproved, pcrq.Date, --ui.fname+', '+ui.Lname   as staffid ,
	case when pcrq.Approved != 1 then ''
		else ui.fname+' '+ui.Lname  end as staffid 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	left join UserInfo ui on pcrq.StaffID = ui.UserId
	where   q.RowIsActive=1 and ProjectCheckReqID = @ProjectCheckReqID
	
end
go

alter procedure GetUserByUserName
(
	@username varchar(50)
)
as 
Begin
	select userid,  Lname + ', ' + Fname as fullname from UserInfo where Username=@username
End
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[getCommittedProjectslist]') and type in (N'P', N'PC'))
drop procedure [dbo].getCommittedProjectslist 
go

Create procedure getCommittedProjectslist  
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 --and tr.LkTransaction = 238
	group by p.projectid, proj_num
	order by proj_num 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[getAvailableFundsForProject]') and type in (N'P', N'PC'))
drop procedure [dbo].getAvailableFundsForProject 
go

Create procedure getAvailableFundsForProject  
as
begin

	select distinct p.projectid, proj_num, round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 and tr.LkTransaction = 238
	group by p.projectid, proj_num
	order by proj_num 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[getAvailableFundsByProject]') and type in (N'P', N'PC'))
drop procedure [dbo].getAvailableFundsByProject 
go

Create procedure getAvailableFundsByProject  
	@projId int
as
begin

	select distinct p.projectid, proj_num, round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 --and tr.LkTransaction = 238 
	and p.ProjectId = @projId
	group by p.projectid, proj_num
	order by proj_num 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectApplicant]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectApplicant 
go

create procedure dbo.GetProjectApplicant
(
	@ProjectId int
) 
as
begin 
	select pa.ProjectApplicantID, 			
			isnull(pa.IsApplicant, 0) as IsApplicant, 
			isnull(pa.FinLegal, 0) as FinLegal,			
			a.ApplicantId, a.Individual, 
			an.applicantname,			
			aan.appnameid, aan.defname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @ProjectId
			and pa.RowIsActive = 1
		order by pa.IsApplicant desc, pa.FinLegal desc, pa.DateModified desc
	end 
go


alter procedure GetProjectIdByProjNum
(
	@filter varchar(20)
)
as
Begin
	select p.projectid, ltrim(lpn.description) as projName, (select description from lookupvalues where  LookupType = 119 and typeid = p.lkprojecttype) as description
		from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname	

	 where p.proj_num = @filter
End
go


alter procedure [dbo].[PCR_Submit]
(
	@ProjectID int, 
	@InitDate date, 
	@LkProgram	int, 
	@LegalReview	bit, 
	@LCB	bit, 
	@MatchAmt	money, 
	@LkFVGrantMatch	int, 
	@Notes	nvarchar(2000), 
	@Disbursement decimal(8,2),
	@Payee int,
	@LkStatus int,
	@UserID	int,
	@LKNODs 	varchar(50),
	@CRDate date,
	@ProjectCheckReqID	int output,
	@TransID	int output
)
as
Begin
begin transaction

	begin try

	insert into ProjectCheckReq(ProjectID, InitDate, LkProgram, LegalReview, 
		LCB, MatchAmt, LkFVGrantMatch, Notes, UserID, crdate)
	values(@ProjectID, @InitDate, @LkProgram, @LegalReview, 
		@LCB, @MatchAmt, @LkFVGrantMatch, @Notes, @UserID, @CRDate)

	set @ProjectCheckReqID = @@IDENTITY

	insert into Trans(ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus)
	values(@ProjectID, @ProjectCheckReqID, @InitDate, @Disbursement, @Payee, 236, @LkStatus)

	set @TransID = @@IDENTITY

	--exec PCR_Submit_NOD @ProjectCheckReqID, @LKNODs

	select pcr.ProjectCheckReqId, CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq, @TransID as transid
	from ProjectCheckReq pcr(nolock)
		join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
		join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
		join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
		join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
		join AppName an(nolock) on aan.AppNameID = an.AppNameID
		join LookupValues lv on lv.TypeID = t.LkStatus
	where pcr.ProjectCheckReqID = @ProjectCheckReqID
	order by pcr.ProjectCheckReqId desc

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
end
go



alter procedure PCR_Update
(
	@ProjectCheckReqID int,
	@ProjectID int, 
	@InitDate date, 
	@LkProgram	int, 
	@LegalReview	bit, 
	@LCB	bit, 
	@MatchAmt	money, 
	@LkFVGrantMatch	int, 
	@Notes	nvarchar(2000), 
	@Disbursement decimal(8,2),
	@Payee int,
	@LkStatus int,
	@UserID	int,
	@LKNODs 	varchar(50),
	@CrDate date,
	@TransID	int output
)
as
begin
	begin transaction

	begin try
		update ProjectCheckReq set ProjectID = @ProjectID, InitDate = @InitDate, LkProgram = @LkProgram, LegalReview = @LegalReview, 
			LCB =  @LCB, MatchAmt = @MatchAmt, LkFVGrantMatch = @LkFVGrantMatch, Notes = @Notes, UserID = @UserID, CRDate = @crDate
		from ProjectCheckReq
		where ProjectCheckReqID = @ProjectCheckReqID

		select @TransID = TransID from Trans where ProjectCheckReqID = @ProjectCheckReqID

		update Trans set ProjectID = ProjectID, Date = @InitDate, TransAmt = @Disbursement, PayeeApplicant = @Payee, LkTransaction = 236, LkStatus = @LkStatus
		from Trans
		where TransID = @TransID

		delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID


		select pcr.ProjectCheckReqId, CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq, @TransID as transid
		from ProjectCheckReq pcr(nolock)
		join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
		join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
		join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
		join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
		join AppName an(nolock) on aan.AppNameID = an.AppNameID
		join LookupValues lv on lv.TypeID = t.LkStatus
	where pcr.ProjectCheckReqID = @ProjectCheckReqID
	order by pcr.ProjectCheckReqId desc
		
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
end
go


alter procedure PCR_Delete
(
	@ProjectCheckReqID int
	
)
as
begin
	begin transaction

	begin try
		declare @transId int
				
		select @transId = transid from trans where ProjectCheckReqID = @ProjectCheckReqID
		delete from detail where transid = @transId
		delete from trans where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReq where ProjectCheckReqID = @ProjectCheckReqID
		
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
end
go


alter procedure PCR_Submit_NOD
(
	@ProjectCheckReqID	int, 
	@LKNOD				int
)
as
begin
	insert into ProjectCheckReqNOD(ProjectCheckReqID, LKNOD)
	values(@ProjectCheckReqID, @LKNOD)
end
go

alter procedure pcr_submit_items
(
	@ProjectCheckReqID	int, 
	@lkPCRItems int
)
as 
Begin
	insert into ProjectCheckReqItems (ProjectCheckReqID, LKCRItems, RowIsActive)
	values (@ProjectCheckReqID, @lkPCRItems, 1)
End
go

alter procedure UpdateVoucherNumber
(
  @voucherNum varchar(10),
  @crDate datetime,
  @userId int,
  @projectCheckReqId int
)
as 
Begin
	update ProjectCheckReq set [Voucher#] = @vouchernum, paiddate = @crdate, Coordinator = @userid where projectcheckreqid = @projectcheckreqid;
	
	select pcrq.projectcheckreqid, pcrq.[Voucher#] as voucherNum, paiddate, pcrq.userid, ui.fname+', '+ui.Lname   as staffid  
	from projectCheckReq pcrq
	left join UserInfo ui on pcrq.Coordinator = ui.UserId
	where pcrq.projectcheckreqid = @projectcheckreqid;
End
go

alter procedure GetVoucherDet
(
	@pcrId int
)
as
Begin
	select pcrq.projectcheckreqid, pcrq.[Voucher#] as voucherNum, paiddate, pcrq.userid, ui.fname+', '+ui.Lname   as staffid  
	from projectCheckReq pcrq
	left join UserInfo ui on pcrq.Coordinator = ui.UserId
	where pcrq.projectcheckreqid = @pcrId;
End
go

alter procedure GetPCRDetails
(
	@ProjectCheckReqId int
)
as
begin
	select ProjectID, InitDate, LkProgram, LegalReview, 
			Final, LCB, MatchAmt, LkFVGrantMatch, Notes, UserID 
	from ProjectCheckReq pcr(nolock)
	where ProjectCheckReqId = @ProjectCheckReqId

	declare @TransId int

	select @TransId = TransId from Trans(nolock) where ProjectCheckReqId = @ProjectCheckReqId

	select TransId, ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus
	from trans t(nolock)
	where ProjectCheckReqId = @ProjectCheckReqId

	select TransId, FundId, LkTransType, Amount
	from Detail (nolock)
	where TransId = @TransId

	exec PCR_Trans_Detail_Load @TransId
	
	select LKNOD from ProjectCheckReqNOD(nolock) where ProjectCheckReqID = @ProjectCheckReqID

	select ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID from ProjectCheckReqQuestions(nolock)  where ProjectCheckReqID = @ProjectCheckReqID

	select pa.applicantid from project p join projectapplicant pa on pa.ProjectId = p.ProjectId
		join projectcheckreq pcr on pcr.ProjectID = p.ProjectId where pa.FinLegal = 1 and pcr.ProjectCheckReqID = @ProjectCheckReqID
	
	Select LKCRItems from ProjectCheckReqItems where ProjectCheckReqID = @ProjectCheckReqID
end
go

