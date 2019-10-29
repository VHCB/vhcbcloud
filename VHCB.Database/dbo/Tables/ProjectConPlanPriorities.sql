CREATE TABLE [dbo].[ProjectConPlanPriorities] (
    [ProjectConPlanPrioritiesID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]                  INT        NOT NULL,
    [LkConplanPriorities]        INT        NOT NULL,
    [RowVersion]                 ROWVERSION NOT NULL,
    [UserID]                     INT        NOT NULL,
    [RowIsActive]                BIT        CONSTRAINT [DF_ProjectLkConPlanPriorities_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]               DATETIME   CONSTRAINT [DF_ProjectLkConPlanPriorities_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectConPlanPriorities] PRIMARY KEY CLUSTERED ([ProjectConPlanPrioritiesID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkConplanPriorities Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'LkConplanPriorities';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities', @level2type = N'COLUMN', @level2name = N'ProjectConPlanPrioritiesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project LkConplanpriorities Link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectConPlanPriorities';

