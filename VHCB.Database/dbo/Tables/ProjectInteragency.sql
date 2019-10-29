CREATE TABLE [dbo].[ProjectInteragency] (
    [ProjectInteragencyID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]            INT        NOT NULL,
    [LkInteragency]        INT        NOT NULL,
    [Numunits]             INT        CONSTRAINT [DF_ProjectInteragency_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]          BIT        CONSTRAINT [DF_ProjectInteragency_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME   CONSTRAINT [DF_ProjectInteragency_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]           ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectInteragency] PRIMARY KEY CLUSTERED ([ProjectInteragencyID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkInteragency Record ID link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'LkInteragency';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency', @level2type = N'COLUMN', @level2name = N'ProjectInteragencyID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Interagency Report Link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectInteragency';

