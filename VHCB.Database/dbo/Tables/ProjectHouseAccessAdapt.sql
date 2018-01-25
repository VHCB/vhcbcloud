CREATE TABLE [dbo].[ProjectHouseAccessAdapt] (
    [ProjectHouseAccessAdaptID] INT      IDENTITY (1, 1) NOT NULL,
    [HousingID]                 INT      NOT NULL,
    [LkUnitChar]                INT      NOT NULL,
    [Numunits]                  INT      CONSTRAINT [DF_ProjectHouseAccessAdapt_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]               BIT      CONSTRAINT [DF_ProjectHouseAccessAdapt_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]              DATETIME CONSTRAINT [DF_ProjectHouseAccessAdapt_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectHouseAccessAdapt] PRIMARY KEY CLUSTERED ([ProjectHouseAccessAdaptID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Numer of units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record Id LkMultiHUType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'LkUnitChar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record Housing ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt', @level2type = N'COLUMN', @level2name = N'ProjectHouseAccessAdaptID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project multi-unit types and number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseAccessAdapt';

