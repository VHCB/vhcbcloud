CREATE TABLE [dbo].[ConserveLegMech] (
    [ConserveLegMechID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]        INT      NOT NULL,
    [LKLegMech]         MONEY    NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ConserveLegMech_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ConserveLegMech_DateModified] DEFAULT (getdate()) NOT NULL
);

