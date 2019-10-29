CREATE TABLE [dbo].[Detail] (
    [DetailID]        INT              IDENTITY (1, 1) NOT NULL,
    [TransId]         INT              NOT NULL,
    [FundId]          INT              NOT NULL,
    [LkTransType]     INT              NOT NULL,
    [ProjectID]       INT              NULL,
    [Amount]          MONEY            NOT NULL,
    [LandUsePermitID] INT              NULL,
    [DetailGuId]      UNIQUEIDENTIFIER NULL,
    [RowIsActive]     BIT              CONSTRAINT [DF_Detail_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME         CONSTRAINT [DF_Detail_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Detail] PRIMARY KEY CLUSTERED ([DetailID] ASC),
    CONSTRAINT [FK_Detail_Trans] FOREIGN KEY ([TransId]) REFERENCES [dbo].[Trans] ([TransId])
);


GO
--Trigger on Detail
CREATE TRIGGER [dbo].[trgIUDDetail] ON [dbo].[Detail] 
after UPDATE, INSERT, DELETE
AS
	declare @TransId int;
	declare @ProjectId int;
	declare @LkTransaction int;
	DECLARE @TransAmount money
	DECLARE @DetailsAmount money
	Declare @IsBalanceZero bit

	--UPDATE
	if exists(SELECT * from inserted) and exists (SELECT * from deleted)
	begin
	select @TransId = i.TransId from inserted i;
	end

	--INSERT
	If exists (Select * from inserted) and not exists(Select * from deleted)
	begin
	select @TransId = i.TransId from inserted i;
	end

	--DELETE
	If exists(select * from deleted) and not exists(Select * from inserted)
	begin 
	SELECT @TransId = i.TransId from deleted i;
	end

	--select @TransAmount = isNull(TransAmt, 0) from Trans(nolock) where TransId = @TransId
 
	--select @DetailsAmount = sum(isnull(Amount, 0 )) from Detail (nolock) where TransId = @TransId and RowIsActive = 1 --and isnull(Amount, 0) > 0

	select @TransAmount = case when isnull(TransAmt, 0) =  0 then isNull(ReallAssignAmt, 0) else TransAmt end,
		@ProjectId = ProjectId, @LkTransaction = LkTransaction
	from Trans(nolock) where TransId = @TransId
 
	if(@LkTransaction = 240)
	select @DetailsAmount = sum(isnull(Amount, 0 )) from Detail (nolock) where TransId = @TransId and RowIsActive = 1 and isnull(Amount, 0) > 0
	else
	select @DetailsAmount = sum(isnull(Amount, 0 )) from Detail (nolock) where TransId = @TransId and RowIsActive = 1 and ProjectId = @ProjectId

	if(ABS(@TransAmount) = ABS(@DetailsAmount))
		set @IsBalanceZero = 1
	else
		set @IsBalanceZero = 0

		print('Updated')
	update Trans set Balanced = @IsBalanceZero where TransId = @TransId
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Land Use Permit #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'LandUsePermitID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'Amount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trans Type lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'LkTransType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fund table index-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'FundId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trans table index-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'TransId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Detail ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail', @level2type = N'COLUMN', @level2name = N'DetailID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Financial Detail info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Detail';

