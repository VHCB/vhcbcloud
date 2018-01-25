CREATE TABLE [dbo].[ProjectLegalInterest_not used] (
    [ProjectLegalInterestID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]              INT        NOT NULL,
    [LkLegalInterest]        INT        NOT NULL,
    [RowVersion]             ROWVERSION NOT NULL,
    [UserID]                 INT        NULL,
    [RowIsActive]            BIT        CONSTRAINT [DF_ProjectLegalInterest_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]           DATETIME   CONSTRAINT [DF_ProjectLegalInterest_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLegalInterest] PRIMARY KEY CLUSTERED ([ProjectLegalInterestID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkLegalInterest record index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'LkLegalInterest';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID Record index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used', @level2type = N'COLUMN', @level2name = N'ProjectLegalInterestID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project link to Legal Interest', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLegalInterest_not used';

