CREATE TABLE [dbo].[LoanTransactions] (
    [LoanTransID]  INT            IDENTITY (1, 1) NOT NULL,
    [LoanID]       INT            NOT NULL,
    [TransType]    INT            NULL,
    [TransDate]    DATE           NULL,
    [IntRate]      FLOAT (53)     NULL,
    [Compound]     INT            NULL,
    [Freq]         INT            NULL,
    [PayType]      INT            NULL,
    [MatDate]      DATE           NULL,
    [StartDate]    DATE           NULL,
    [Amount]       MONEY          NULL,
    [StopDate]     DATE           NULL,
    [Principal]    MONEY          NULL,
    [Interest]     MONEY          NULL,
    [Description]  NVARCHAR (150) NULL,
    [TransferTo]   INT            NULL,
    [ConvertFrom]  INT            NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_LoanPayments_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_LoanPayments_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LoanPayments] PRIMARY KEY CLUSTERED ([LoanTransID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Interest Amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'Interest';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Principle Amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'Principal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'TransDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Either Cash Receipt or Capitalizing Accrued Interest', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'TransType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LoanMasterID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'LoanID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanTransactions', @level2type = N'COLUMN', @level2name = N'LoanTransID';

