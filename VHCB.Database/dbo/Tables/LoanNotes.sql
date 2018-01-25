CREATE TABLE [dbo].[LoanNotes] (
    [LoanNoteID]   INT             IDENTITY (1, 1) NOT NULL,
    [LoanID]       INT             NOT NULL,
    [LoanNote]     NVARCHAR (MAX)  NOT NULL,
    [FHLink]       NVARCHAR (4000) NULL,
    [RowIsActive]  BIT             CONSTRAINT [DF_LoanNotes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME        CONSTRAINT [DF_LoanNotes_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LoanNotes] PRIMARY KEY CLUSTERED ([LoanNoteID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanNotes', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanNotes', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of Note', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanNotes', @level2type = N'COLUMN', @level2name = N'LoanNote';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LoanMasterID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanNotes', @level2type = N'COLUMN', @level2name = N'LoanID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LoanNotes', @level2type = N'COLUMN', @level2name = N'LoanNoteID';

