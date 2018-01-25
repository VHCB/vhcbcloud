CREATE TABLE [dbo].[ProjectLeadProgDocs] (
    [ProjectLeadProgDocsID] INT            IDENTITY (1, 1) NOT NULL,
    [ProjectId]             INT            NOT NULL,
    [LkLeadProgDocs]        INT            NOT NULL,
    [Date]                  DATE           NULL,
    [Notes]                 NVARCHAR (MAX) NULL,
    [RowIsActive]           BIT            CONSTRAINT [DF_ProjectLeadProgDocs_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]          DATETIME       CONSTRAINT [DF_ProjectLeadProgDocs_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLeadProgDocs] PRIMARY KEY CLUSTERED ([ProjectLeadProgDocsID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Notes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'Notes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of Program/Document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link from LkLeadProgDocs-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'LkLeadProgDocs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs', @level2type = N'COLUMN', @level2name = N'ProjectLeadProgDocsID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link beween Project and LkLeadProgDocs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadProgDocs';

