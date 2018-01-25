CREATE TABLE [dbo].[ProjectNotes] (
    [ProjectNotesID]    INT             IDENTITY (1, 1) NOT NULL,
    [ProjectId]         INT             NOT NULL,
    [LkCategory]        INT             NOT NULL,
    [UserId]            INT             NULL,
    [Date]              DATE            NULL,
    [Notes]             NVARCHAR (MAX)  NULL,
    [ProjectCheckReqID] INT             NULL,
    [URL]               NVARCHAR (1500) NULL,
    [PageID]            INT             NULL,
    [RowIsActive]       BIT             CONSTRAINT [DF_ProjectNotes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME        CONSTRAINT [DF_ProjNotes_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectNotes] PRIMARY KEY CLUSTERED ([ProjectNotesID] ASC),
    CONSTRAINT [FK_ProjNotes_UserInfo] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserInfo] ([UserId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Notes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'Notes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of visit, etc.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'UserId', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'UserId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkProjNotes lookup-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'LkCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes', @level2type = N'COLUMN', @level2name = N'ProjectNotesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link between Project and Notes table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNotes';

