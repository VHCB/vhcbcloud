use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAmericopMemberInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAmericopMemberInfo
go

CREATE procedure GetAmericopMemberInfo
(
	@ProjectId		int
)
--exec GetAmericopMemberInfo 6638
as
begin
	select  a.email, --isnull(nullif(a.cellphone, ''), isnull(nullif(a.WorkPhone, ''), a.HomePhone)) cellphone, 
	a.cellphone, pa.Applicantid, 
		isnull(c.Firstname, '') + ' ' + isnull(c.MI, '') + isnull(c.Lastname, '') name,
		convert(varchar(10), c.DOB, 101) DOB, c.ContactId
	from applicant a(nolock)
	join applicantContact ac(nolock) on ac.ApplicantID =  a.ApplicantId
	join Contact c(nolock) on c.ContactId = ac.ContactID
	--join ApplicantAppName aan(nolock) on aan.ApplicantID = a.ApplicantId
	--join AppName an(nolock) on an.AppNameID = aan.AppNameID
	join projectapplicant pa(nolock) on pa.applicantid = a.applicantid
	where pa.LkApplicantRole =  26294 --Americorps Member
		and pa.RowIsActive = 1 
		and pa.ProjectId = @ProjectId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateContactDOB]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateContactDOB
go

CREATE procedure UpdateContactDOB
(
	@ApplicantId	int,
	@DOB			DateTime
)
--exec UpdateContactDOB 6638
as
begin

update c set c.DOB = @DOB 
	from applicant a(nolock)
	join applicantContact ac(nolock) on ac.ApplicantID =  a.ApplicantId
	join Contact c(nolock) on c.ContactId = ac.ContactID
	join projectapplicant pa(nolock) on pa.applicantid = a.applicantid
	where a.ApplicantId = @ApplicantId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantAddress]') and type in (N'P', N'PC'))
drop procedure [dbo].GetApplicantAddress
go

CREATE procedure GetApplicantAddress
(
	@Applicantid		int
)
--exec GetApplicantAddress 1248
as
begin
	select top 1 a.AddressId, LkAddressType, lv.Description AddressType, Street#, Address1, Address2, Town, State, Zip, County, Country
	from ApplicantAddress aa(nolock)
	join address a(nolock) on aa.addressid = a.addressid
	left join LookupValues lv(nolock) on lv.TypeID = a.LkAddressType
	where a.RowIsActive = 1 and aa.applicantid = @Applicantid
	order by LkAddressType
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetACMember]') and type in (N'P', N'PC'))
drop procedure [dbo].GetACMember
go

create procedure dbo.GetACMember
(
	@ApplicantID	int
) as
begin
-- exec GetACMember 1119
	select ACMemberID, ApplicantID, ContactID, convert(varchar(10), StartDate, 101)StartDate,   convert(varchar(10), EndDate, 101) EndDate, LkSlot, 
	LkServiceType, Tshirt, SweatShirt, DietPref, MedConcerns, Notes
	from ACMembers where ApplicantID = @ApplicantID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddACMember]') and type in (N'P', N'PC'))
drop procedure [dbo].AddACMember
go

create procedure dbo.AddACMember
(
	@ApplicantID	int, 
	@ContactID		int,
	@StartDate		datetime, 
	@EndDate		datetime, 
	@LkSlot			int, 
	@LkServiceType	int, 
	@Tshirt			int, 
	@SweatShirt		int, 
	@DietPref		int, 
	@MedConcerns	nvarchar(350), 
	@Notes			nvarchar(max), 
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ACMembers(nolock)
		where ApplicantID = @ApplicantID 
    )
	begin
		insert into ACMembers(ApplicantID, ContactID, StartDate, EndDate, LkSlot, LkServiceType, Tshirt, SweatShirt, DietPref, MedConcerns, Notes)
		values(@ApplicantID, @ContactID, @StartDate, @EndDate, @LkSlot, @LkServiceType, @Tshirt, @SweatShirt, @DietPref, @MedConcerns, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ACMembers(nolock)
		where ApplicantID = @ApplicantID 
	end

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateACMember]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateACMember
go

create procedure dbo.UpdateACMember
(
	@ACMemberID		int, 
	@StartDate		datetime, 
	@EndDate		datetime, 
	@LkSlot			int, 
	@LkServiceType	int, 
	@Tshirt			int, 
	@SweatShirt		int, 
	@DietPref		int, 
	@MedConcerns	nvarchar(350), 
	@Notes			nvarchar(max)
) as
begin 
		update ACMembers set StartDate = @StartDate, EndDate = @EndDate, LkSlot = @LkSlot, LkServiceType = @LkServiceType, Tshirt = @Tshirt, SweatShirt = @SweatShirt, DietPref = @DietPref, MedConcerns = @MedConcerns, Notes = @Notes
		where ACMemberID = @ACMemberID
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetACMemberFormData]') and type in (N'P', N'PC'))
drop procedure [dbo].GetACMemberFormData
go

create procedure dbo.GetACMemberFormData
( 
	@ACMemberID		int,
	@Groupnum		int,
	@isActive		bit
) as
begin
--exec GetACMemberFormData 5, 1
	select ACMemberID, af.Groupnum, lv.description GroupName, Name, af.ACFormID, isnull(ACmemberformID, -99) ACmemberformID, isnull(Received, 0) Received, 
	Date as ReceivedDate, isnull(URL, '') URL, 
	substring(Notes, 0, 25) Notes,  Notes as FullNotes, 
	isnull(amf.RowIsActive, 1) RowIsActive
	from acforms af(nolock)
	left join acmemberform amf(nolock) on amf.ACFormID = af.ACFormID and ACMemberID = @ACMemberID --and (@isActive = 0 or amf.RowIsActive = @isActive)
	join LookupValues lv(nolock) on lv.TypeID = af.Groupnum
	where af.Groupnum = @Groupnum  --and (@isActive = 0 or amf.RowIsActive = @isActive)
	order by ordernum
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetACMemberFormDataById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetACMemberFormDataById
go

create procedure dbo.GetACMemberFormDataById
(
	@ACmemberformID		int
) as
begin
	select amf.ACMemberID, amf.ACFormID, amf.Received, convert(varchar(10), amf.Date, 101)   as ReceivedDate, amf.URL, 
	substring( amf.Notes, 0, 25) Notes,  amf.Notes as FullNotes, amf.RowIsActive, amf.DateModified, 
	af.[Name] FormName, af.Groupnum
	from acmemberform amf(nolock)
	join acforms af(nolock) on amf.ACFormID = af.ACFormID
	where ACmemberformID = @ACmemberformID 
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddACMemberForm]') and type in (N'P', N'PC'))
drop procedure [dbo].AddACMemberForm
go

create procedure dbo.AddACMemberForm
(
	@ACMemberID		int, 
	@ACFormID		int, 
	@Received		bit, 
	@Date			datetime, 
	@URL			nvarchar(50),
	@Notes			nvarchar(max), 
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ACMemberForm(nolock)
		where ACMemberID = @ACMemberID and ACFormID = @ACFormID
    )
	begin
		insert into ACMemberForm(ACMemberID, ACFormID, Received, Date, URL, Notes)
		values(@ACMemberID, @ACFormID, @Received, @Date, @URL, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ACMemberForm(nolock)
		where ACMemberID = @ACMemberID and ACFormID = @ACFormID
	end

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
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateACMemberForm]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateACMemberForm
go

create procedure dbo.UpdateACMemberForm
(
	@ACMemberFormId	int, 
	@Received		bit, 
	@Date			datetime, 
	@URL			nvarchar(50),
	@Notes			nvarchar(max),
	@RowisActive	bit
) as
begin 

	update ACMemberForm set Received = @Received, Date = @Date, URL = @URL, Notes = @Notes, RowisActive = @RowisActive
	where ACMemberFormId = @ACMemberFormId
		
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetACForms]') and type in (N'P', N'PC'))
drop procedure [dbo].GetACForms
go


create procedure dbo.GetACForms
(
	@Groupnum		int
) as
begin
	select ACFormID, Name 
	from acforms where Groupnum = @Groupnum and RowIsActive = 1
end
go

