use VHCBSandbox
go

/*   AppraisalValue */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationAppraisalValue]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationAppraisalValue
go

create procedure dbo.AddConservationAppraisalValue
(
	@ProjectID		int, 
	@TotAcres		int, 
	@Apbef			money, 
	@Apaft			money, 
	@Aplandopt		money, 
	@Exclusion		money, 
	@EaseValue		money, 
	@Valperacre		money,
	@Comments		nvarchar(max)
) as
begin transaction

	begin try
		insert into AppraisalValue(ProjectID, TotAcres, Apbef, Apaft, Aplandopt, Exclusion, EaseValue, Valperacre, Comments)
		values(@ProjectID, @TotAcres, @Apbef, @Apaft, @Aplandopt, @Exclusion, @EaseValue, @Valperacre, @Comments)

		if not exists
		(
			select 1
			from Conserve(nolock)
			where ProjectID = @ProjectId
		)
		begin
			insert into Conserve(ProjectID, TotalAcres, DateModified)
			values(@ProjectID, @TotAcres, getdate())
		end
		else
		begin
			update conserve set TotalAcres = @TotAcres
			from conserve
			where ProjectID = @ProjectID 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationAppraisalValue]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationAppraisalValue
go

create procedure dbo.UpdateConservationAppraisalValue
(
	@ProjectID		int, 
	@TotAcres		int, 
	@Apbef			money, 
	@Apaft			money, 
	@Aplandopt		money, 
	@Exclusion		money, 
	@EaseValue		money, 
	@Valperacre		money,
	@Comments		nvarchar(max),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update AppraisalValue set  TotAcres = @TotAcres, Apbef = @Apbef, Apaft = @Apaft, Aplandopt = @Aplandopt, 
		Exclusion = @Exclusion, EaseValue = @EaseValue, Valperacre = @Valperacre, RowIsActive = @IsRowIsActive, DateModified = getdate(),
		Comments = @Comments
	from AppraisalValue
	where ProjectID = @ProjectID
	
	update conserve set TotalAcres = @TotAcres
	from conserve
	where ProjectID = @ProjectID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationAppraisalValueById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationAppraisalValueById 
go

create procedure GetConservationAppraisalValueById
(
	@ProjectID int
)  
as
--exec GetConservationAppraisalValueById 6588
begin

	declare @TotAcres int

	select @TotAcres = TotalAcres
	from Conserve(nolock)
	where ProjectID = @ProjectID

	select AppraisalID, ProjectID, @TotAcres as TotAcres, Apbef, Apaft, Aplandopt, Exclusion, EaseValue, Valperacre, RowIsActive, Comments
	from AppraisalValue (nolock)
	where ProjectID = @ProjectID
end
go


/* AppraisalInfo */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationAppraisalInfoList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationAppraisalInfoList
go

create procedure GetConservationAppraisalInfoList  
(
	@AppraisalID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetConservationAppraisalInfoList 6625, 1
	select ai.AppraisalInfoID, ai.AppraisalID, ai.LkAppraiser, description as 'Appraiser', ai.AppOrdered, ai.AppRecd, ai.EffDate, ai.AppCost, 
		ai.Comment, ai.NRCSSent, ai.RevApproved, ai.ReviewDate, ai.RowIsActive, ai.DateModified,
		ai.URL,
		CASE when isnull(ai.URL, '') = '' then '' else 'Click here' end as URLText
	from AppraisalInfo ai(nolock)
	left join LookupValues (nolock) on TypeID = ai.LkAppraiser
	where ai.AppraisalID = @AppraisalID
		and (@IsActiveOnly = 0 or ai.RowIsActive = @IsActiveOnly)
	order by ai.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationAppraisalInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationAppraisalInfo
go

create procedure dbo.AddConservationAppraisalInfo
(
	@AppraisalID	int, 
	@LkAppraiser	int, 
	@AppOrdered		datetime, 
	@AppRecd		datetime, 
	@EffDate		datetime, 
	@AppCost		money, 
	@Comment		nvarchar(max), 
	@NRCSSent		datetime, 
	@RevApproved	bit, 
	@ReviewDate		datetime,
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
		from AppraisalInfo(nolock)
		where LkAppraiser = @LkAppraiser and AppOrdered = @AppOrdered
	)
	begin

		insert into AppraisalInfo(AppraisalID, LkAppraiser, AppOrdered, AppRecd, EffDate, AppCost, 
			Comment, NRCSSent, RevApproved, ReviewDate)
		values(@AppraisalID, @LkAppraiser, @AppOrdered, @AppRecd, @EffDate, @AppCost, 
			@Comment, @NRCSSent, @RevApproved, @ReviewDate)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from AppraisalInfo(nolock)
		where LkAppraiser = @LkAppraiser and AppOrdered = @AppOrdered
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationAppraisalInfo]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationAppraisalInfo
go

create procedure dbo.UpdateConservationAppraisalInfo
(
	@AppraisalInfoID int, 
	@LkAppraiser	int, 
	@AppOrdered		datetime, 
	@AppRecd		datetime, 
	@EffDate		datetime, 
	@AppCost		money, 
	@Comment		nvarchar(max), 
	@NRCSSent		datetime, 
	@RevApproved	bit, 
	@ReviewDate		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update AppraisalInfo set LkAppraiser = @LkAppraiser, AppOrdered = @AppOrdered, AppRecd = @AppRecd, EffDate = @EffDate, 
		AppCost = @AppCost, Comment = @Comment, NRCSSent = @NRCSSent, RevApproved = @RevApproved, ReviewDate = @ReviewDate, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from AppraisalInfo
	where AppraisalInfoID = @AppraisalInfoID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationAppraisalInfoById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationAppraisalInfoById 
go

create procedure GetConservationAppraisalInfoById
(
	@AppraisalInfoID int
)  
as
--exec GetConservationAppraisalInfoById 6588
begin

	select AppraisalID, LkAppraiser, AppOrdered, AppRecd, EffDate, convert(varchar(10), AppCost) AppCost , Comment, NRCSSent, RevApproved, ReviewDate, RowIsActive, DateModified, URL
	from AppraisalInfo (nolock)
	where AppraisalInfoID = @AppraisalInfoID
end
go

/* AppraisalPay */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationAppraisalPayList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationAppraisalPayList
go

create procedure GetConservationAppraisalPayList  
(
	@AppraisalInfoID	int,
	@IsActiveOnly		bit
)
as
begin
--exec GetConservationAppraisalPayList 6625, 1
	select pay.AppraisalPayID, pay.PayAmt, an.applicantname WhoPaid, a.applicantid, --pay.WhoPaid, 
	pay.RowIsActive
	from AppraisalPay pay(nolock)
	join applicantappname aan(nolock) on pay.WhoPaid = aan.ApplicantID
	join appname an(nolock) on aan.appnameid = an.appnameid
	join applicant a(nolock) on a.applicantid = aan.applicantid
	where pay.AppraisalInfoID = @AppraisalInfoID
		and (@IsActiveOnly = 0 or pay.RowIsActive = @IsActiveOnly)
	order by pay.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationAppraisalPay]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationAppraisalPay
go

create procedure dbo.AddConservationAppraisalPay
(
	@AppraisalInfoID	int, 
	@PayAmt				money, 
	@WhoPaid			int
) as
begin transaction

	begin try

	insert into AppraisalPay(AppraisalInfoID, PayAmt, WhoPaid)
	values(@AppraisalInfoID, @PayAmt, @WhoPaid)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationAppraisalPay]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationAppraisalPay
go

create procedure dbo.UpdateConservationAppraisalPay
(
	@AppraisalPayID int, 
	@PayAmt			money, 
	@WhoPaid		int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update AppraisalPay set PayAmt = @PayAmt, WhoPaid = @WhoPaid,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from AppraisalPay
	where AppraisalPayID = @AppraisalPayID
	
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
