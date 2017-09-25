use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetAmeicopMemberInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].GetAmeicopMemberInfo
go

CREATE procedure GetAmeicopMemberInfo
(
	@ProjectId		int
)
--exec GetAmeicopMemberInfo 6638
as
begin
	select  a.email, isnull(nullif(a.cellphone, ''), isnull(nullif(a.WorkPhone, ''), a.HomePhone)) phone, pa.Applicantid, 
		isnull(c.Firstname, '') + ' ' + isnull(c.MI, '') + isnull(c.Lastname, '') name,
		c.DOB
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
	select top 1 a.AddressId, LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, Country
	from ApplicantAddress aa(nolock)
	join address a(nolock) on aa.addressid = a.addressid
	where a.RowIsActive = 1 and aa.applicantid = @Applicantid
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

select top 2 * from ACForms
select * from acmemberform

select Name, af.ACFormID, ACmemberformID, Received, Date, URL, Notes, amf.RowIsActive
from acforms af(nolock)
left join acmemberform amf(nolock) on amf.ACFormID = af.ACFormID
where Groupnum = 26730
order by ordernum

select distinct groupnum from acforms