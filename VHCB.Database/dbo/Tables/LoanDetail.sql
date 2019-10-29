CREATE TABLE [dbo].[LoanDetail] (
    [LoanDetailID] INT        IDENTITY (1, 1) NOT NULL,
    [LoanID]       INT        NULL,
    [LoanCat]      INT        NULL,
    [NoteDate]     DATE       NOT NULL,
    [MaturityDate] DATE       NOT NULL,
    [IntRate]      FLOAT (53) NOT NULL,
    [Compound]     INT        NULL,
    [Frequency]    INT        NULL,
    [PaymentType]  INT        NULL,
    [WatchDate]    DATE       NULL,
    [RowIsActive]  BIT        CONSTRAINT [DF_LoanDetail_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME   CONSTRAINT [DF_LoanDetail_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LoanDetail] PRIMARY KEY CLUSTERED ([LoanDetailID] ASC),
    CONSTRAINT [FK_LoanDetail_LoanMaster] FOREIGN KEY ([LoanID]) REFERENCES [dbo].[LoanMaster] ([LoanID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Watch Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'WatchDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Payments Y/N', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'PaymentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Compounded ? Y/N', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'Compound';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Interest Rate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'IntRate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Maturity Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'MaturityDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Note Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'NoteDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Category', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanDetail', @level2type = N'COLUMN', @level2name = N'LoanCat';

