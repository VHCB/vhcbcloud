CREATE TABLE [dbo].[ProjectRelated] (
    [ProjectRelatedID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]        INT        NULL,
    [RelProjectID]     INT        NOT NULL,
    [Related$]         MONEY      CONSTRAINT [DF_ProjectRelated_Related$] DEFAULT ((0)) NOT NULL,
    [LkRelreason]      INT        NULL,
    [DualGoal]         BIT        CONSTRAINT [DF_ProjectRelated_DualGoal] DEFAULT ((0)) NOT NULL,
    [DateModified]     DATETIME   CONSTRAINT [DF_ProjectRelated_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]       ROWVERSION NOT NULL,
    [RowIsActive]      BIT        CONSTRAINT [DF__ProjectRe__RowIs__70B86AB0] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_ProjectRelated] PRIMARY KEY CLUSTERED ([ProjectRelatedID] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Relationship connection', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'LkRelreason';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is money related?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'Related$';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Related Project ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'RelProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated', @level2type = N'COLUMN', @level2name = N'ProjectRelatedID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project link to related projects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectRelated';

