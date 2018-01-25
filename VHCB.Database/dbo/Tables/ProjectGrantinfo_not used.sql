CREATE TABLE [dbo].[ProjectGrantinfo_not used] (
    [ProjectGrantInfoID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]          INT        NOT NULL,
    [GrantinfoID]        INT        NOT NULL,
    [RowVersion]         ROWVERSION NOT NULL,
    [UserID]             INT        NULL,
    [RowIsActive]        BIT        CONSTRAINT [DF_ProjectGrantinfo_RowIsActive_1] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME   CONSTRAINT [DF_ProjectGrantinfo_DateModified_1] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectGrantinfo] PRIMARY KEY CLUSTERED ([ProjectGrantInfoID] ASC),
    CONSTRAINT [FK_ProjectGrantinfo_GrantInfo] FOREIGN KEY ([GrantinfoID]) REFERENCES [dbo].[GrantInfo] ([GrantinfoID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grantinfo recrod ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'GrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'ProjectGrantInfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Grantinfo link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectGrantinfo_not used';

