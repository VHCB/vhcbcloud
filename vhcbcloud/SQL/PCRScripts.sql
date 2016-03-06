use VHCBSandbox
go

alter procedure PCR_Projects
as
begin
	select project_id, proj_num, project_name,  convert(varchar(25), project_id) +'|' + project_name as project_id_name
	from project_v where project_id in(
			select distinct ProjectId  from [dbo].[ProjectCheckReq]
			union
			select distinct ProjectId from [dbo].[Trans])
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
as
begin
	select an.Applicantname 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	where aan.DefName = 1
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


create procedure PCR_Program
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkProgram')
		and RowIsActive = 1
	order by TypeID
end
go

create procedure PCR_MatchingGrant
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = 73
		and RowIsActive = 1
	order by TypeID
end
go

create procedure PCR_FundName_Commitments
as
begin
	select distinct name, f.FundId from fund f(nolock)
	join Detail d(nolock) on d.FundId = f.FundId
	order by f.FundId
end
go


create procedure PCR_TransType
as
begin
	select distinct v.Description, v.typeid from LkTransType_v v(nolock)
	join Detail d(nolock) on v.typeid = d.LkTransType
	order by v.typeid
end
go

create procedure PCR_State_VHCBS
as
begin
	select StateAcctnum
	from dbo.stateaccount sa(nolock)
	--where LkTransType = 241
end
go

create procedure PCR_Submit
(
	@ProjectID int, 
	@InitDate date, 
	@LkProgram	int, 
	@LegalReview	bit, 
	@Final	bit, 
	@LCB	bit, 
	@MatchAmt	money, 
	@LkFVGrantMatch	int, 
	@Notes	nvarchar(2000), 
	@Disbursement decimal,
	@Payee int,
	@UserID	int,
	@ProjectCheckReqID	int output,
	@TransID	int output
)
as
begin

	insert into ProjectCheckReq(ProjectID, InitDate, LkProgram, LegalReview, 
		Final, LCB, MatchAmt, LkFVGrantMatch, Notes, UserID)
	values(@ProjectID, @InitDate, @LkProgram, @LegalReview, 
		@Final, @LCB, @MatchAmt, @LkFVGrantMatch, @Notes, @UserID)

	set @ProjectCheckReqID = @@IDENTITY

	insert into Trans(ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus)
	values(@ProjectID, @ProjectCheckReqID, @InitDate, @Disbursement, @Payee, 236, 124)

	set @TransID = @@IDENTITY

end
go

create procedure PCR_Trans_Detail_Submit
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

create procedure PCR_Trans_Detail_Load
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

create procedure PCR_NOD_Load
as
begin
	select typeid, LookupType, Description 
	from LookupValues(nolock)
	where LookupType = (select RecordID from LkLookups where tablename = 'LkNOD')
		and RowIsActive = 1
end
go

create procedure PCR_Questions
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
	insert into ProjectCheckReqQuestions(ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID)
	values(@ProjectCheckReqID, @LkPCRQuestionsID, @Approved, @Date, @StaffID)

	
	declare @pos int
	declare @len int
	declare @value varchar(10)

	set @pos = 0
	set @len = 0

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

--truncate table ProjectCheckReqNOD
--select * from ProjectCheckReqNOD
--sp_help ProjectCheckReqQuestions
--select * from ProjectCheckReqQuestions 
--select * from LkPCRQuestions
----select * from [dbo].[LkLookups] where recordid = 34
----select * from [dbo].[Lkstatus_v]LkProgram

----sp_helptext Lkstatus_v

--select distinct LkTransType from Detail
--select distinct v.Description, v.typeid from LkTransType_v v(nolock)
--join Detail d(nolock) on v.typeid = d.LkTransType
--order by v.typeid


--select StateAcctnum, * 
--from dbo.stateaccount sa(nolock)
--where LkTransType = 241

--select DeptID, VHCBCode, * from fund 
--select * from Detail
--select * from [ProjectCheckReq] order by DateModified desc
--select * from trans order by DateModified desc
--select * from detail order by DateModified desc
--delete from [ProjectCheckReq] where [ProjectCheckReqID] = 33
--delete from trans where transID = 1608

--PCR_Program

--select * from UserInfo
--sp_help ProjectCheckReq
