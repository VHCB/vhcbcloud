CREATE TABLE [dbo].[LkDevlpr] (
    [TypeId]       INT           IDENTITY (1, 1) NOT NULL,
    [Description]  NVARCHAR (50) NULL,
    [DevId]        NVARCHAR (25) NOT NULL,
    [IsRowActive]  BIT           CONSTRAINT [DF_LkDevlpr_IsRowActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Devlpr_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkDevlpr] PRIMARY KEY CLUSTERED ([TypeId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr', @level2type = N'COLUMN', @level2name = N'IsRowActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Old Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr', @level2type = N'COLUMN', @level2name = N'DevId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Developer Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID - primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr', @level2type = N'COLUMN', @level2name = N'TypeId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to Act250Dev and Mitigation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkDevlpr';

