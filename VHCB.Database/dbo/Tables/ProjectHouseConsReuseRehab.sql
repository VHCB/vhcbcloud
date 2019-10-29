CREATE TABLE [dbo].[ProjectHouseConsReuseRehab] (
    [ProjectHouseConsReuseRehabID] INT      IDENTITY (1, 1) NOT NULL,
    [HousingID]                    INT      NOT NULL,
    [LkUnitChar]                   INT      NOT NULL,
    [Numunits]                     INT      CONSTRAINT [DF_ProjectHouseConsReuseRehab_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]                  BIT      CONSTRAINT [DF_ProjectHouseConsReuseRehab_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]                 DATETIME CONSTRAINT [DF_ProjectHouseConsReuseRehab_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectHouseConsReuseRehab] PRIMARY KEY CLUSTERED ([ProjectHouseConsReuseRehabID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LookUpType record ID=145', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'LkUnitChar';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab', @level2type = N'COLUMN', @level2name = N'ProjectHouseConsReuseRehabID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project unit types and number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseConsReuseRehab';

