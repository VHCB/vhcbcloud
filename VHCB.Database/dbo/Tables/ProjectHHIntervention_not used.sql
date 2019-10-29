CREATE TABLE [dbo].[ProjectHHIntervention_not used] (
    [ProjectHHInterventionID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]               INT        NOT NULL,
    [LkHHInterventions]       INT        NOT NULL,
    [RowIsActive]             BIT        CONSTRAINT [DF_ProjectHHIntervention_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]            DATETIME   CONSTRAINT [DF_ProjectHHIntervention_datemodified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]              ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectHHIntervention] PRIMARY KEY CLUSTERED ([ProjectHHInterventionID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkHHInterventions lookup-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used', @level2type = N'COLUMN', @level2name = N'LkHHInterventions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used', @level2type = N'COLUMN', @level2name = N'ProjectHHInterventionID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HH Link between Projects and Interventions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHHIntervention_not used';

