CREATE TABLE [dbo].[FundGrantinfo] (
    [FundGrantinfoID] INT      IDENTITY (1, 1) NOT NULL,
    [FundID]          INT      NOT NULL,
    [GrantinfoID]     INT      NOT NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_ProjectGrantinfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_ProjectGrantinfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FundGrantinfo] PRIMARY KEY CLUSTERED ([FundGrantinfoID] ASC),
    CONSTRAINT [FK_FundGrantinfo_GrantInfo] FOREIGN KEY ([GrantinfoID]) REFERENCES [dbo].[GrantInfo] ([GrantinfoID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grantinfo Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo', @level2type = N'COLUMN', @level2name = N'GrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo', @level2type = N'COLUMN', @level2name = N'FundID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo', @level2type = N'COLUMN', @level2name = N'FundGrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grantinfo link to Projects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FundGrantinfo';

