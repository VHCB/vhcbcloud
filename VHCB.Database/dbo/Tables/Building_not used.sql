CREATE TABLE [dbo].[Building_not used] (
    [BuildingID]   INT           IDENTITY (1, 1) NOT NULL,
    [ProjectAddID] INT           NOT NULL,
    [Bldgname]     NVARCHAR (50) NULL,
    [Units]        INT           NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_Building_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Building_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED ([BuildingID] ASC),
    CONSTRAINT [FK_Building_Address] FOREIGN KEY ([ProjectAddID]) REFERENCES [dbo].[Address] ([AddressId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of units in bldg', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'Units';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building name/ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'Bldgname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID of address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'ProjectAddID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used', @level2type = N'COLUMN', @level2name = N'BuildingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Building_not used';

