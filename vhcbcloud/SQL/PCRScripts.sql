use VHCBSandbox
go

alter procedure PCR_Projects
as
begin
	select project_id, proj_num, project_name,  convert(varchar(25), project_id) +'|' + project_name as project_id_name
	from project_v 
	--where project_id in(
	--		select distinct ProjectId  from [dbo].[ProjectCheckReq]
	--		union
	--		select distinct ProjectId from [dbo].[Trans])
	order by proj_num
end
go

alter procedure PCR_Dates
as
begin
	select distinct convert(varchar(10), InitDate) as Date  from [dbo].[ProjectCheckReq]
	union
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
	where aan.DefName = 1 and projectID = @ProjectID
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

alter procedure PCR_Submit
(
	@ProjectID int, 
	@InitDate date, 
	@LkProgram	int, 
	@LegalReview	bit, 
	@LCB	bit, 
	@MatchAmt	money, 
	@LkFVGrantMatch	int, 
	@Notes	nvarchar(2000), 
	@Disbursement decimal,
	@Payee int,
	@LkStatus int,
	@UserID	int,
	@ProjectCheckReqID	int output,
	@TransID	int output
)
as
begin

	insert into ProjectCheckReq(ProjectID, InitDate, LkProgram, LegalReview, 
		LCB, MatchAmt, LkFVGrantMatch, Notes, UserID)
	values(@ProjectID, @InitDate, @LkProgram, @LegalReview, 
		@LCB, @MatchAmt, @LkFVGrantMatch, @Notes, @UserID)

	set @ProjectCheckReqID = @@IDENTITY

	insert into Trans(ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus)
	values(@ProjectID, @ProjectCheckReqID, @InitDate, @Disbursement, @Payee, 236, @LkStatus)

	set @TransID = @@IDENTITY

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
			d.LkTransType, t.LkTransaction  
from Fund f 
			join Detail d on d.FundId = f.FundId
			join Trans t on t.TransId = d.TransId
			join LookupValues lv on lv.TypeID = d.LkTransType
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
		select TypeID, Description from  LkPCRQuestions where def = 1 and RowIsActive = 1
	else
	begin
		select TypeID, Description from  LkPCRQuestions where def = 1 and RowIsActive = 1
		union all
		select TypeID, Description from  LkPCRQuestions where TypeID = 7

	end
end
go

alter procedure PCR_Submit_Questions
(
	@ProjectCheckReqID	int, 
	@LkPCRQuestionsID	int, 
	@Approved			bit, 
	@Date				date, 
	@StaffID			int,
	@LKNODs				varchar(50)
)
as
begin

	delete from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID

	insert into ProjectCheckReqQuestions(ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID)
	values(@ProjectCheckReqID, @LkPCRQuestionsID, @Approved, @Date, @StaffID)

	delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID

	declare @pos int
	declare @len int
	declare @value varchar(10)

	set @pos = 0
	set @len = 0

	set @LKNODs = @LKNODs + '|';
	while charindex('|', @LKNODs, @pos+1)>0
	begin
		set @len = charindex('|', @LKNODs, @pos+1) - @pos
		set @value = substring(@LKNODs, @pos, @len)
		--select @pos, @len, @value 
		--print @value
		insert into ProjectCheckReqNOD(ProjectCheckReqID, LKNOD) values(@ProjectCheckReqID, @value)

		set @pos = charindex('|', @LKNODs, @pos+@len) +1
	end
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
