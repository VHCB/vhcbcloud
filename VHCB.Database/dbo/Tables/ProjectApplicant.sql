CREATE TABLE [dbo].[ProjectApplicant] (
    [ProjectApplicantID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]          INT        NOT NULL,
    [ApplicantId]        INT        NOT NULL,
    [LkApplicantRole]    INT        NOT NULL,
    [Defapp]             BIT        CONSTRAINT [DF_ProjectApplicant_Default] DEFAULT ((1)) NOT NULL,
    [IsApplicant]        BIT        NULL,
    [FinLegal]           BIT        NULL,
    [RowVersion]         ROWVERSION NOT NULL,
    [UserID]             INT        NULL,
    [RowIsActive]        BIT        CONSTRAINT [DF_ProjectOrg_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME   CONSTRAINT [DF_ProjectApplicant_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectApplicant_1] PRIMARY KEY CLUSTERED ([ProjectApplicantID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Financial/Legal Checkbox for ability to receive check', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'FinLegal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Applicant actual applicant or something else?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'IsApplicant';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default applicant-helps if more than 1 applicant - only 1 can be default', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'Defapp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Role of Organization to Project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'LkApplicantRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Organization ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'ApplicantId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant', @level2type = N'COLUMN', @level2name = N'ProjectApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to Role of Applicant', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectApplicant';

