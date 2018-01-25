CREATE TABLE [dbo].[ProjectLegalMech_not used] (
    [ProjectLegalMech] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]        INT        NOT NULL,
    [LkLegalMechanism] INT        NOT NULL,
    [RowIsActive]      BIT        CONSTRAINT [DF_ProjLegalMech_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     NCHAR (10) CONSTRAINT [DF_PrLegalMech_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]       ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectLegalMech] PRIMARY KEY CLUSTERED ([ProjectLegalMech] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkLMId lookup-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used', @level2type = N'COLUMN', @level2name = N'LkLegalMechanism';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used', @level2type = N'COLUMN', @level2name = N'ProjectLegalMech';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Legal Mechanism lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalMech_not used';

