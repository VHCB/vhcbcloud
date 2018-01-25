CREATE TABLE [dbo].[ConserveEholder] (
    [ConserveEholderID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]        INT      NOT NULL,
    [ApplicantId]       INT      NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ProjEholder_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ProjEholder_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveEholder_1] PRIMARY KEY CLUSTERED ([ConserveEholderID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder', @level2type = N'COLUMN', @level2name = N'ApplicantId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder', @level2type = N'COLUMN', @level2name = N'ConserveEholderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Easement Holders-link between Project and Organization', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveEholder';

