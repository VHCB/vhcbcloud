CREATE TABLE [dbo].[Mitigation] (
    [MitigationID] INT           IDENTITY (1, 1) NOT NULL,
    [GrantInfoID]  INT           NOT NULL,
    [District#]    INT           NOT NULL,
    [LkDevlpr]     INT           NOT NULL,
    [LkTown]       INT           NOT NULL,
    [Permit#]      NVARCHAR (15) NOT NULL,
    [Anticipated]  MONEY         CONSTRAINT [DF_Mitigation_Anticipated] DEFAULT ((0)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Mitigation_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Mitigation] PRIMARY KEY CLUSTERED ([MitigationID] ASC),
    CONSTRAINT [FK_Mitigation_GrantInfo] FOREIGN KEY ([GrantInfoID]) REFERENCES [dbo].[GrantInfo] ([GrantinfoID]),
    CONSTRAINT [FK_Mitigation_LkDevlpr] FOREIGN KEY ([LkDevlpr]) REFERENCES [dbo].[LkDevlpr] ([TypeId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Anticipated Dollars', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'Anticipated';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Land Use Permit #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'Permit#';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'LkTown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Developer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'LkDevlpr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'District #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'District#';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grantinfo Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'GrantInfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID - primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation', @level2type = N'COLUMN', @level2name = N'MitigationID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mitigation Master', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Mitigation';

