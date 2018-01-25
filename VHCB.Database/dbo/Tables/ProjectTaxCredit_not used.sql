CREATE TABLE [dbo].[ProjectTaxCredit_not used] (
    [ProjectTaxCreditID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]          INT        NOT NULL,
    [LKTaxCredit]        INT        NOT NULL,
    [ServDate]           DATE       NOT NULL,
    [amount]             MONEY      NULL,
    [CompDate]           DATE       NULL,
    [DateModified]       DATETIME   CONSTRAINT [DF_ProjectTaxCredit_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]         ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectTaxCredit] PRIMARY KEY CLUSTERED ([ProjectTaxCreditID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Estimated end of Complianced date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'CompDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amount of tax credit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'amount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of Service', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'ServDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of Tax Credit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'LKTaxCredit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used', @level2type = N'COLUMN', @level2name = N'ProjectTaxCreditID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Tax Credit info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectTaxCredit_not used';

