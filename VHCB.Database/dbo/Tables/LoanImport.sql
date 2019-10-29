CREATE TABLE [dbo].[LoanImport] (
    [LoanImportID] INT      NOT NULL,
    [ProjectID]    INT      NOT NULL,
    [DetailID]     INT      NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_LoanImport_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_LoanImport_DateModified] DEFAULT (getdate()) NOT NULL
);

