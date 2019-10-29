CREATE TABLE [dbo].[ProjectFederalIncomeRest] (
    [ProjectFederalIncomeRestID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectFederalID]           INT      NOT NULL,
    [LkAffordunits]              INT      NOT NULL,
    [Numunits]                   INT      CONSTRAINT [DF_ProjectFederalIncomeRest_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]                BIT      CONSTRAINT [DF_ProjectFederalIncomeRest_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]               DATETIME CONSTRAINT [DF_ProjectFederalIncomeRest_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectFederalIncomeRest] PRIMARY KEY CLUSTERED ([ProjectFederalIncomeRestID] ASC)
);

