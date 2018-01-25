CREATE TABLE [dbo].[ProjectOtherOutcomes] (
    [ProjectOtherOutcomesID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]              INT        NOT NULL,
    [LkOtherOutcomes]        INT        NOT NULL,
    [Numunits]               INT        CONSTRAINT [DF_ProjectOtherOutcomes_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]            BIT        CONSTRAINT [DF_ProjectOtherOutcomes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]           DATETIME   CONSTRAINT [DF_ProjectOtherOutcomes_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]             ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectOtherOutcomes] PRIMARY KEY CLUSTERED ([ProjectOtherOutcomesID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkOtherOutcomes Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'LkOtherOutcomes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes', @level2type = N'COLUMN', @level2name = N'ProjectOtherOutcomesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Other Outcomes Link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectOtherOutcomes';

