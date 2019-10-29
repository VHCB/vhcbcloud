CREATE TABLE [dbo].[LoanDet] (
    [DetailLoanID] INT      NOT NULL,
    [MasterLoanID] INT      NOT NULL,
    [DetailID]     INT      NULL,
    [FundID]       INT      NULL,
    [NoteAmt]      MONEY    NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_LoanDet_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_LoanDet_DateModified] DEFAULT (getdate()) NOT NULL
);

