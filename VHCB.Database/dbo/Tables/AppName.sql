CREATE TABLE [dbo].[AppName] (
    [AppNameID]      INT           IDENTITY (1, 1) NOT NULL,
    [Applicantname]  NVARCHAR (60) NULL,
    [ApplicantAbbrv] NCHAR (12)    NULL,
    [RowIsActive]    BIT           CONSTRAINT [DF_Table_1_Active] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME      CONSTRAINT [DF_OrgName_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ApplicantName] PRIMARY KEY CLUSTERED ([AppNameID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppName', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppName', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant abbreviation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppName', @level2type = N'COLUMN', @level2name = N'ApplicantAbbrv';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppName', @level2type = N'COLUMN', @level2name = N'Applicantname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant''s Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppName';

