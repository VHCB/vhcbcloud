CREATE TABLE [dbo].[ProjectHouseSubType] (
    [HousingTypeID] INT      IDENTITY (1, 1) NOT NULL,
    [HousingID]     INT      NOT NULL,
    [LkHouseType]   INT      NOT NULL,
    [Units]         INT      NOT NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_ProjectHouseSubType_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_ProjectHouseSubType_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectHouseSubType] PRIMARY KEY CLUSTERED ([HousingTypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'Units';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkTypeID=127 or 128', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'LkHouseType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSubType', @level2type = N'COLUMN', @level2name = N'HousingTypeID';

