CREATE TABLE [dbo].[AgreementAward_not used] (
    [AgreeAwardID]   INT           NOT NULL,
    [ProjectID]      INT           NOT NULL,
    [SignedDate]     DATE          NULL,
    [Description]    NVARCHAR (50) NULL,
    [DateSent]       DATE          NULL,
    [DateRecd]       DATE          NULL,
    [ExpirationDate] DATE          NULL,
    [DateModified]   DATETIME      CONSTRAINT [DF_FundAward_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FundAward] PRIMARY KEY CLUSTERED ([AgreeAwardID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Expiration Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'ExpirationDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'DateRecd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Award End Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'DateSent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of award', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Award Begin Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'SignedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used', @level2type = N'COLUMN', @level2name = N'AgreeAwardID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Agreement Awards', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgreementAward_not used';

