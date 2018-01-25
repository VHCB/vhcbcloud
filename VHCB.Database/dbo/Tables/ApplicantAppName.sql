CREATE TABLE [dbo].[ApplicantAppName] (
    [ApplicantAppNameID] INT      IDENTITY (1, 1) NOT NULL,
    [ApplicantID]        INT      NOT NULL,
    [AppNameID]          INT      NOT NULL,
    [DefName]            BIT      NOT NULL,
    [RowIsActive]        BIT      CONSTRAINT [DF_ApplicantAppName_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME CONSTRAINT [DF_ApplicantAppName_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ApplicantAppName] PRIMARY KEY CLUSTERED ([ApplicantAppNameID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant''s default name?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'DefName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'App Name record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'AppNameID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName', @level2type = N'COLUMN', @level2name = N'ApplicantAppNameID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Relationship between Applicant and AppName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAppName';

