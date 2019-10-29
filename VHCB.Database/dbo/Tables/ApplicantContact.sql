CREATE TABLE [dbo].[ApplicantContact] (
    [ApplicantContactID] INT      IDENTITY (1, 1) NOT NULL,
    [ApplicantID]        INT      NULL,
    [ContactID]          INT      NOT NULL,
    [ProjectID]          INT      NULL,
    [DfltCont]           BIT      NULL,
    [RowIsActive]        BIT      CONSTRAINT [DF_ApplicantContact_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME CONSTRAINT [DF_ApplicantContact_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ApplicantContact] PRIMARY KEY CLUSTERED ([ApplicantContactID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default contact for Applicant''s Organization', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'DfltCont';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'ContactID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Organization ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact', @level2type = N'COLUMN', @level2name = N'ApplicantContactID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant link to Contact and Organization', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantContact';

