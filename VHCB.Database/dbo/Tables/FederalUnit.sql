CREATE TABLE [dbo].[FederalUnit] (
    [FederalUnitID]    INT      IDENTITY (1, 1) NOT NULL,
    [ProjectFederalID] INT      NOT NULL,
    [UnitType]         INT      NOT NULL,
    [NumUnits]         INT      NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_FederalUnitTypes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_FederalUnitTypes_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FederalUnitTypes] PRIMARY KEY CLUSTERED ([FederalUnitID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'NumUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of Unit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'UnitType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Federal ID index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'ProjectFederalID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FederalUnit', @level2type = N'COLUMN', @level2name = N'FederalUnitID';

