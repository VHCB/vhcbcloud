CREATE TABLE [dbo].[EntityNotes] (
    [EntityNotesID] INT             IDENTITY (1, 1) NOT NULL,
    [EntityID]      INT             NOT NULL,
    [LkCategory]    INT             NULL,
    [UserID]        INT             NULL,
    [Date]          DATE            CONSTRAINT [DF_EntityNotes_Date] DEFAULT (getdate()) NULL,
    [Notes]         NVARCHAR (MAX)  NULL,
    [URL]           NVARCHAR (1500) NULL,
    [RowIsActive]   BIT             CONSTRAINT [DF_EntityNotes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME        CONSTRAINT [DF_EntityNotes_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'FileHold URL', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'URL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Notes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'Notes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date - not required', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID of staff making entry into record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Category of Note', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'LkCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Entity ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'EntityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EntityNotes', @level2type = N'COLUMN', @level2name = N'EntityNotesID';

