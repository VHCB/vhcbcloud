CREATE TABLE [dbo].[ConserveLegInterest] (
    [ConserveLegInterestID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]            INT      NOT NULL,
    [LKLegInterest]         INT      NOT NULL,
    [RowIsActive]           BIT      CONSTRAINT [DF_ConserveLegInterest_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]          DATETIME CONSTRAINT [DF_ConserveLegInterest_DateModified] DEFAULT (getdate()) NOT NULL
);

