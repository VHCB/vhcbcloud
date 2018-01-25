CREATE TABLE [dbo].[LoanEvents] (
    [LoanEventID]  INT            IDENTITY (1, 1) NOT NULL,
    [LoanID]       INT            NOT NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_LoanEvents_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_LoanEvents_DateModified] DEFAULT (getdate()) NOT NULL
);

