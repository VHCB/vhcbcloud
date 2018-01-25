CREATE TABLE [dbo].[LkLookups] (
    [RecordID]      INT            IDENTITY (1, 1) NOT NULL,
    [Tablename]     NVARCHAR (25)  NOT NULL,
    [Viewname]      NVARCHAR (40)  NOT NULL,
    [LKDescription] NVARCHAR (MAX) NULL,
    [Standard]      BIT            CONSTRAINT [DF_LkLookups_Standard] DEFAULT ((1)) NOT NULL,
    [Ordered]       BIT            CONSTRAINT [DF_LkLookups_Ordered] DEFAULT ((0)) NOT NULL,
    [Tiered]        BIT            CONSTRAINT [DF_LkLookups_Tiered] DEFAULT ((0)) NOT NULL,
    [RowIsActive]   BIT            CONSTRAINT [DF_LkLookups_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME       CONSTRAINT [DF_LkLookups_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkLookups] PRIMARY KEY CLUSTERED ([RecordID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Determines if lookup is 3 standard fields', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'Standard';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'LKDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name on interface page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'Viewname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'Tablename';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups', @level2type = N'COLUMN', @level2name = N'RecordID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table to programmatically present interface for lookup tables maintenance lookup to LookupValues', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLookups';

