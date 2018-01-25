CREATE TABLE [dbo].[ProjectApplicantGrant_not used] (
    [ProjectAppGrantID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectID]         INT        NOT NULL,
    [ApplicantID]       INT        NOT NULL,
    [OrganGrantID]      INT        NOT NULL,
    [RowVersion]        ROWVERSION NOT NULL,
    [UserID]            INT        NULL,
    [RowIsActive]       BIT        CONSTRAINT [DF_ProjectApplicantGrant_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME   CONSTRAINT [DF_ProjectApplicantGrant_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectApplicantGrant] PRIMARY KEY CLUSTERED ([ProjectAppGrantID] ASC),
    CONSTRAINT [FK_ProjectApplicantGrant_OrganGrantApp] FOREIGN KEY ([OrganGrantID]) REFERENCES [dbo].[OrganGrantApp_not used] ([OrganGrantID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'OrganGrantApp Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'OrganGrantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used', @level2type = N'COLUMN', @level2name = N'ProjectAppGrantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Applicant Organizational Grant info by fiscal year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicantGrant_not used';

