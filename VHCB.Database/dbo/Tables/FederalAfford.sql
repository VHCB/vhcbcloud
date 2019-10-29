CREATE TABLE [dbo].[FederalAfford] (
    [FederalAffordID]  INT      IDENTITY (1, 1) NOT NULL,
    [ProjectFederalID] INT      NOT NULL,
    [AffordType]       INT      NOT NULL,
    [NumUnits]         INT      NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_FederalAfford_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_FederalAfford_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table is Rent Restrictions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalAfford', @level2type = N'COLUMN', @level2name = N'FederalAffordID';

