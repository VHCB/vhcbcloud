CREATE TABLE [dbo].[ProjectHHHouseitem_not used] (
    [ProjectHHHouseItemID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]            INT        NOT NULL,
    [LkHHHouseItem]        INT        NOT NULL,
    [Numinstall]           INT        NULL,
    [RowIsActive]          BIT        CONSTRAINT [DF_ProjectHHHouseitem_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME   CONSTRAINT [DF_ProjectHHHouseitem_datemodified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]           ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectHHHouseitem] PRIMARY KEY CLUSTERED ([ProjectHHHouseItemID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of installs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'Numinstall';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkHHHouse item lookup-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'LkHHHouseItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used', @level2type = N'COLUMN', @level2name = N'ProjectHHHouseItemID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HH Link between Project and HouseItems', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHHouseitem_not used';

