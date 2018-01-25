CREATE TABLE [dbo].[LoanMaster] (
    [LoanID]           INT           IDENTITY (1, 1) NOT NULL,
    [ProjectID]        INT           NOT NULL,
    [NoteAmt]          MONEY         NULL,
    [Descriptor]       NVARCHAR (75) NULL,
    [TaxCreditPartner] NVARCHAR (75) NULL,
    [ApplicantID]      INT           NULL,
    [DetailID]         INT           NULL,
    [NoteOwner]        NVARCHAR (75) NULL,
    [FundID]           INT           NULL,
    [ImportDate]       DATE          NULL,
    [RowIsActive]      BIT           CONSTRAINT [DF_LoanMaster_RowIsActive_1] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME      CONSTRAINT [DF_LoanMaster_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LoanMaster] PRIMARY KEY CLUSTERED ([LoanID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record imported from Finalizing transaction', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'ImportDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Detail record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'DetailID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Applicant', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tax Credit Partnership', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'TaxCreditPartner';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ProjectID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanMaster', @level2type = N'COLUMN', @level2name = N'LoanID';

