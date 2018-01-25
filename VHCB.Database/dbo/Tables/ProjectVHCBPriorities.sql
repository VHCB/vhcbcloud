CREATE TABLE [dbo].[ProjectVHCBPriorities] (
    [ProjectVHCBPrioritiesID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]               INT        NOT NULL,
    [LkVHCBPriorities]        INT        NOT NULL,
    [RowIsActive]             BIT        CONSTRAINT [DF_ProjectVHCBPriorities_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]            DATETIME   CONSTRAINT [DF_ProjectVHCBPriorities_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]              ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectVHCBPriorities] PRIMARY KEY CLUSTERED ([ProjectVHCBPrioritiesID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkVHCBPriorities Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities', @level2type = N'COLUMN', @level2name = N'LkVHCBPriorities';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities', @level2type = N'COLUMN', @level2name = N'ProjectVHCBPrioritiesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project VHCB Priorities Link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectVHCBPriorities';

