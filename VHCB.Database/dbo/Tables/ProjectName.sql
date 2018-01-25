CREATE TABLE [dbo].[ProjectName] (
    [ProjectNameID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]     INT        NOT NULL,
    [LkProjectname] INT        NULL,
    [DefName]       BIT        NULL,
    [RowIsActive]   BIT        NULL,
    [DateModified]  DATETIME   CONSTRAINT [DF_ProjectNames_DateModified] DEFAULT (getdate()) NULL,
    [RowVersion]    ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectName] PRIMARY KEY CLUSTERED ([ProjectNameID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName', @level2type = N'COLUMN', @level2name = N'DefName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName', @level2type = N'COLUMN', @level2name = N'LkProjectname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID - Project Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName', @level2type = N'COLUMN', @level2name = N'ProjectNameID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Names for Projects as they change', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectName';

