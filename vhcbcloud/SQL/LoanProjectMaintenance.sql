use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanMasterListByProject]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanMasterListByProject
go

create procedure dbo.GetLoanMasterListByProject
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
--GetLoanMasterListByProject 6583, 1
begin transaction

	begin try

	select LoanID, ProjectID, Descriptor, TaxCreditPartner, ApplicantID, DetailID, NoteOwner, FundID, ImportDate, RowIsActive
	from LoanMaster lm(nolock) 
	where lm.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or lm.RowIsActive = @IsActiveOnly)
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanMasterDetailsByLoanID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanMasterDetailsByLoanID
go

create procedure dbo.GetLoanMasterDetailsByLoanID
(
	@LoanID int
) as
--GetLoanMasterDetailsByLoanID 1
begin transaction

	begin try
	
	select LoanID, ProjectID, Descriptor, TaxCreditPartner, ApplicantID, DetailID, NoteOwner, FundID, ImportDate, RowIsActive
	from LoanMaster lm(nolock) 
	where lm.LoanID = @LoanID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLoanMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLoanMaster
go

create procedure dbo.AddLoanMaster
(
	@ProjectID			int, 
	@Descriptor			nvarchar(75), 
	@TaxCreditPartner	nvarchar(75), 
	@ApplicantID		int,
	@NoteOwner			nvarchar(75), 
	@FundID				int
) as
begin transaction

	begin try

	insert into LoanMaster(ProjectID, Descriptor, TaxCreditPartner, ApplicantID, NoteOwner, FundID)
	values(@ProjectID, @Descriptor, @TaxCreditPartner, @ApplicantID, @NoteOwner, @FundID)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLoanMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLoanMaster
go

create procedure dbo.UpdateLoanMaster
(
	@LoanID				int, 
	@Descriptor			nvarchar(75), 
	@TaxCreditPartner	nvarchar(75), 
	@ApplicantID		int,
	@NoteOwner			nvarchar(75), 
	@FundID				int,
	@RowIsActive	bit
) as
begin transaction

	begin try

	update LoanMaster set Descriptor = @Descriptor, TaxCreditPartner = @TaxCreditPartner, ApplicantID = @ApplicantID, 
		NoteOwner = @NoteOwner, FundID = @FundID, RowIsActive = @RowIsActive
	from LoanMaster
	where LoanID = @LoanID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanDetailListByLoanId]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanDetailListByLoanId
go

create procedure dbo.GetLoanDetailListByLoanId
(
	@LoanId			int,
	@IsActiveOnly	bit
) as
--GetLoanDetailListByLoanId 6583, 1
begin transaction

	begin try

	select ld.LoanDetailID, ld.LoanID, ld.LoanCat, ld.NoteDate, ld.MaturityDate, ld.NoteAmt, ld.IntRate, ld.Compound, ld.Frequency, 
		ld.PaymentType, ld.WatchDate, ld.RowIsActive
	from LoanDetail ld(nolock)
	where ld.LoanId = @LoanId
	and (@IsActiveOnly = 0 or ld.RowIsActive = @IsActiveOnly)
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLoanDetail]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLoanDetail
go

create procedure dbo.AddLoanDetail
(
	@LoanID			int, 
	@LoanCat		int, 
	@NoteDate		date, 
	@MaturityDate	date, 
	@NoteAmt		money, 
	@IntRate		float, 
	@Compound		int, 
	@Frequency		int, 
	@PaymentType	int, 
	@WatchDate		date
) as
begin transaction

	begin try

	insert into LoanDetail(LoanID, LoanCat, NoteDate, MaturityDate, NoteAmt, IntRate, Compound, Frequency, PaymentType, WatchDate)
	values(@LoanID, @LoanCat, @NoteDate, @MaturityDate, @NoteAmt, @IntRate, @Compound, @Frequency, @PaymentType, @WatchDate)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLoanDetail]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLoanDetail
go

create procedure dbo.UpdateLoanDetail
(
	@LoanDetailID	int,
	@LoanCat		int, 
	@NoteDate		date, 
	@MaturityDate	date, 
	@NoteAmt		money, 
	@IntRate		float, 
	@Compound		int, 
	@Frequency		int, 
	@PaymentType	int, 
	@WatchDate		date,
	@RowIsActive	bit
) as
begin transaction

	begin try

	update LoanDetail set LoanCat = @LoanCat, NoteDate = @NoteDate, MaturityDate = @MaturityDate, NoteAmt = @NoteAmt,
		IntRate = @IntRate, Compound = @Compound, Frequency = @Frequency, PaymentType = @PaymentType, WatchDate = @WatchDate,
		RowIsActive = @RowIsActive
	from LoanDetail
	where LoanDetailID = @LoanDetailID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanDetailsByLoanDetailId]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanDetailsByLoanDetailId
go

create procedure dbo.GetLoanDetailsByLoanDetailId
(
	@LoanDetailID		int
) as
--GetLoanDetailsByLoanDetailId 6583
begin transaction

	begin try

	select ld.LoanDetailID, ld.LoanID, ld.LoanCat, ld.NoteDate, ld.MaturityDate, ld.NoteAmt, ld.IntRate, ld.Compound, ld.Frequency, 
		ld.PaymentType, ld.WatchDate, ld.RowIsActive
	from LoanDetail ld
	where LoanDetailID = @LoanDetailID
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

/* LoanEvent */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLoanEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLoanEvent
go

create procedure dbo.AddLoanEvent
(
	@LoanID			int, 
	@Description	nvarchar(max),
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
		from LoanEvents(nolock)
		where LoanID = @LoanID 
			and Description = @Description
	)
	begin

		insert into LoanEvents(LoanID, Description)
		values(@LoanID, @Description)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from LoanEvents(nolock)
		where LoanID = @LoanID 
			and Description = @Description
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLoanEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLoanEvent
go

create procedure dbo.UpdateLoanEvent
(
	@LoanEventID	int,
	@Description	nvarchar(max), 
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update LoanEvents set Description = @Description,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from LoanEvents
	where LoanEventID = @LoanEventID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanEventsListByLoanID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanEventsListByLoanID
go

create procedure dbo.GetLoanEventsListByLoanID
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanEventsListByLoanID 1
begin transaction

	begin try
	
	select LoanEventID, LoanID, Description, RowIsActive
	from LoanEvents lm(nolock) 
	where lm.LoanID = @LoanID
	and (@IsActiveOnly = 0 or lm.RowIsActive = @IsActiveOnly)

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

/* LoanNotes */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLoanNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLoanNotes
go

create procedure dbo.AddLoanNotes
(
	@LoanID			int, 
	@LoanNote		nvarchar(max),
	@FHLink			nvarchar(4000),
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
		from LoanNotes(nolock)
		where LoanID = @LoanID 
			and LoanNote = @LoanNote
			and FHLink = @FHLink
	)
	begin

		insert into LoanNotes(LoanID, LoanNote, FHLink)
		values(@LoanID, @LoanNote, @FHLink)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from LoanNotes(nolock)
		where LoanID = @LoanID 
			and LoanNote = @LoanNote
			and FHLink = @FHLink
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLoanNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLoanNotes
go

create procedure dbo.UpdateLoanNotes
(
	@LoanNoteID	int,
	@LoanNote	nvarchar(max), 
	@FHLink		nvarchar(4000),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update LoanNotes set LoanNote = @LoanNote, FHLink = @FHLink,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from LoanNotes
	where LoanNoteID = @LoanNoteID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanNotesListByLoanID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanNotesListByLoanID
go

create procedure dbo.GetLoanNotesListByLoanID
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanNotesListByLoanID 1, 1
begin transaction

	begin try
	
	select LoanNoteID, LoanID, LoanNote, FHLink, RowIsActive
	from LoanNotes lm(nolock) 
	where lm.LoanID = @LoanID
	and (@IsActiveOnly = 0 or lm.RowIsActive = @IsActiveOnly)

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanNotesByLoanID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanNotesByLoanID
go

create procedure dbo.GetLoanNotesByLoanID
(
	@LoanNoteID			int
) as
--GetLoanNotesByLoanID 1, 1
begin transaction

	begin try
	
	select LoanNoteID, LoanID, LoanNote, FHLink, RowIsActive
	from LoanNotes lm(nolock) 
	where lm.LoanNoteID = @LoanNoteID
	

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

/*LoanTransactions*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddLoanTransactions]') and type in (N'P', N'PC'))
drop procedure [dbo].AddLoanTransactions
go

create procedure dbo.AddLoanTransactions
(
	@LoanID			int, 
	@TransType		int, 
	@TransDate		datetime, 
	@IntRate		float = null, 
	@Compound		int = null,
	@Freq			int = null,
	@PayType		int = null,
	@MatDate		datetime = null,
	@StartDate		datetime = null,
	@Amount			money = null,
	@StopDate		datetime = null,
	@Principal		money = null,
	@Interest		money = null,
	@Description	nvarchar(150) = null, 
	@TransferTo		int = null,
	@ConvertFrom	int = null
) as
begin transaction

	begin try

		insert into LoanTransactions(LoanID, TransType, TransDate, IntRate, Compound, Freq, PayType, MatDate, StartDate, 
			Amount, StopDate, Principal, Interest, Description, TransferTo, ConvertFrom)
		values(@LoanID, @TransType, @TransDate, @IntRate, @Compound, @Freq, @PayType, @MatDate, @StartDate,
		 @Amount, @StopDate, @Principal, @Interest, @Description, @TransferTo, @ConvertFrom)

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
<<<<<<< HEAD
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateLoanTransactions]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateLoanTransactions
go

create procedure dbo.UpdateLoanTransactions
(
	@LoanTransID	int, 
	@TransType		int, 
	@TransDate		datetime, 
	@IntRate		float = null, 
	@Compound		int = null,
	@Freq			int = null,
	@PayType		int = null,
	@MatDate		datetime = null,
	@StartDate		datetime = null,
	@Amount			money = null,
	@StopDate		datetime = null,
	@Principal		money = null,
	@Interest		money = null,
	@Description	nvarchar(150) = null, 
	@TransferTo		int = null,
	@ConvertFrom	int = null,
	@RowIsActive	bit
) as
begin transaction

	begin try

		update LoanTransactions set TransType = @TransType, TransDate = @TransDate, IntRate = @IntRate, Compound = @Compound, Freq = @Freq, 
		PayType = @PayType, MatDate = @MatDate, StartDate = @StartDate, Amount = @Amount, StopDate = @StopDate, Principal = @Principal, Interest = @Interest, 
		Description = @Description, TransferTo = @TransferTo, ConvertFrom = @ConvertFrom, RowIsActive = @RowIsActive
		where LoanTransID = @LoanTransID

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


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanTransactionsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanTransactionsList
go

create procedure dbo.GetLoanTransactionsList
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanTransactionsList 11, 1
begin transaction

	begin try
	
	select LoanTransID, LoanID, TransType, lv.description as TransTypeDesc, TransDate, IntRate, Compound, Freq, PayType, 
		MatDate, StartDate, Amount, StopDate, Principal, Interest, lt.Description, TransferTo, 
		ConvertFrom, lt.RowIsActive, lt.DateModified 
	from LoanTransactions lt(nolock) 
	left join lookupvalues lv(nolock) on lv.Typeid = lt.TransType
	where lt.LoanID = @LoanID
	and (@IsActiveOnly = 0 or lt.RowIsActive = @IsActiveOnly)
	order by lt.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLoanTransByLoanID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLoanTransByLoanID
go

create procedure dbo.GetLoanTransByLoanID
(
	@LoanTransID			int
) as
--GetLoanTransByLoanID 2
begin transaction

	begin try
	
	select LoanID, TransType, TransDate, IntRate, Compound, Freq, PayType, MatDate, StartDate, 
		Amount, StopDate, Principal, Interest, Description, TransferTo, ConvertFrom, RowIsActive
	from LoanTransactions lm(nolock) 
	where lm.LoanTransID = @LoanTransID
	

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