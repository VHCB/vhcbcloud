CREATE TABLE [dbo].[ProjectFederal] (
    [ProjectFederalID] INT      IDENTITY (1, 1) NOT NULL,
    [LkFedProg]        INT      NOT NULL,
    [ProjectID]        INT      NOT NULL,
    [NumUnits]         INT      NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_ProjectFederal_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_ProjectFederal_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectFederal] PRIMARY KEY CLUSTERED ([ProjectFederalID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'NumUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkFedProg record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'LkFedProg';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Prmary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal', @level2type = N'COLUMN', @level2name = N'ProjectFederalID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Federal Program ID link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederal';

