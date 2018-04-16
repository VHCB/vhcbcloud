CREATE TABLE [dbo].[Applicant] (
    [ApplicantId]      INT           IDENTITY (1, 1) NOT NULL,
    [LkEntityType]     INT           NULL,
    [LKEntityType2]    INT           NULL,
    [LKEnterpriseType] INT           NULL,
    [AppRole]          INT           NULL,
    [StartDate]        DATE          NULL,
    [EndDate]          DATE          NULL,
    [Individual]       BIT           CONSTRAINT [DF_Applicant_Individual] DEFAULT ((0)) NOT NULL,
    [FYend]            NVARCHAR (5)  NULL,
    [W9]               BIT           CONSTRAINT [DF_Applicant_W9] DEFAULT ((0)) NOT NULL,
    [website]          NVARCHAR (75) NULL,
    [email]            NVARCHAR (75) NULL,
    [HomePhone]        NCHAR (10)    NULL,
    [WorkPhone]        NCHAR (10)    NULL,
    [CellPhone]        NCHAR (10)    NULL,
    [LkPhoneType]      INT           NULL,
    [Phone]            NCHAR (10)    NULL,
    [Stvendid]         NVARCHAR (12) NULL,
    [FinLegal]         BIT           CONSTRAINT [DF_Applicant_FinLegal] DEFAULT ((0)) NULL,
    [RowVersion]       ROWVERSION    NOT NULL,
    [UserID]           INT           NULL,
    [RowIsActive]      BIT           CONSTRAINT [DF_Organization_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME      CONSTRAINT [DF_Organization_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Applicant] PRIMARY KEY CLUSTERED ([ApplicantId] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Financial/Legal Checkbox for ability to receive check', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'FinLegal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State vendor ID-historical-not used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'Stvendid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Website', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'website';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fiscal year end date-month and day', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'FYend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant end date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant start date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Individual, Organization, Farm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'LKEntityType2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup for entity types', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'LkEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant', @level2type = N'COLUMN', @level2name = N'ApplicantId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Applicant';

