CREATE TABLE [dbo].[ApplicantVHCBPrograms_not used] (
    [ApplicantVHCBProgramsID] INT      IDENTITY (1, 1) NOT NULL,
    [ApplicantID]             INT      NOT NULL,
    [LkProgram]               INT      NOT NULL,
    [DateModified]            DATETIME CONSTRAINT [DF_ApplicantVHCBPrograms_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ApplicantVHCBPrograms] PRIMARY KEY CLUSTERED ([ApplicantVHCBProgramsID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantVHCBPrograms_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkProgram record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantVHCBPrograms_not used', @level2type = N'COLUMN', @level2name = N'LkProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantVHCBPrograms_not used', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantVHCBPrograms_not used', @level2type = N'COLUMN', @level2name = N'ApplicantVHCBProgramsID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant''s associated VHCB Programs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantVHCBPrograms_not used';

