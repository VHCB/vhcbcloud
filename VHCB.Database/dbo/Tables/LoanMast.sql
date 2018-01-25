CREATE TABLE [dbo].[LoanMast] (
    [MasterLoanID]     INT           NOT NULL,
    [ProjectID]        INT           NOT NULL,
    [PromNote]         INT           NOT NULL,
    [TaxCreditPartner] NVARCHAR (50) NULL,
    [ApplicantID]      INT           NULL,
    [NoteOwner]        NVARCHAR (50) NULL,
    [LoanCat]          INT           NULL,
    [NoteDate]         DATE          NULL,
    [MaturityDate]     DATE          NULL,
    [IntRate]          FLOAT (53)    NULL,
    [Compound]         INT           NULL,
    [Freq]             INT           NULL,
    [PayType]          INT           NULL,
    [WatchDate]        DATE          NULL,
    [RowIsActive]      BIT           CONSTRAINT [DF_LoanMast_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME      CONSTRAINT [DF_LoanMast_DateModified] DEFAULT (getdate()) NOT NULL
);

