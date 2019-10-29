CREATE TABLE [dbo].[ProjectHHWorkPerformed_not Used] (
    [ProjectHHWorkPerformedID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]                INT        NOT NULL,
    [LkHHWorkPerformed]        INT        NOT NULL,
    [RowVersion]               ROWVERSION NOT NULL,
    [RowIsActive]              BIT        CONSTRAINT [DF_ProjectHHWorkPerformed_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]             DATETIME   CONSTRAINT [DF_ProjectHHWorkPerformed_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectHHWorkPerformed] PRIMARY KEY CLUSTERED ([ProjectHHWorkPerformedID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkHHWorkPerformed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used', @level2type = N'COLUMN', @level2name = N'LkHHWorkPerformed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used', @level2type = N'COLUMN', @level2name = N'ProjectHHWorkPerformedID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Healthy Homes Work Performed selections', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHWorkPerformed_not Used';

