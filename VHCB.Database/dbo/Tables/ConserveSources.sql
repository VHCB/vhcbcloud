CREATE TABLE [dbo].[ConserveSources] (
    [ConserveSourcesID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveSUID]      INT      NOT NULL,
    [LkConSource]       INT      NOT NULL,
    [Total]             MONEY    NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ConserveSources_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ConserveSources_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveSources] PRIMARY KEY CLUSTERED ([ConserveSourcesID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total $ Amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'Total';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Lookup to LkConSource', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'LkConSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Conserve', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'ConserveSUID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources', @level2type = N'COLUMN', @level2name = N'ConserveSourcesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Project Sources', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSources';

