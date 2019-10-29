CREATE TABLE [dbo].[FHLinkHousing_not used] (
    [TypeID]       INT           IDENTITY (1, 1) NOT NULL,
    [Description]  NVARCHAR (50) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_FHLinkHousing_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHLinkHousing_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHLinkHousing_not used', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHLinkHousing_not used', @level2type = N'COLUMN', @level2name = N'TypeID';

