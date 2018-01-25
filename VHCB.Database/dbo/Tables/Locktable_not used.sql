CREATE TABLE [dbo].[Locktable_not used] (
    [LockID]       INT           IDENTITY (1, 1) NOT NULL,
    [Filename]     NVARCHAR (50) NOT NULL,
    [RecordKey]    INT           NOT NULL,
    [Time]         ROWVERSION    NOT NULL,
    [userid]       INT           NOT NULL,
    [locklifespan] INT           NOT NULL,
    CONSTRAINT [PK_Locktable] PRIMARY KEY CLUSTERED ([LockID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amount of time to keep record locked if not unlocked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'locklifespan';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User who locked record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'userid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Time initiating lock', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'Time';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Key of record to be locked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'RecordKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of file to be locked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'Filename';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used', @level2type = N'COLUMN', @level2name = N'LockID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lock table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Locktable_not used';

