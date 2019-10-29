CREATE TABLE [dbo].[GrantinfoFYAmt] (
    [GrantInfoFY]  INT      IDENTITY (1, 1) NOT NULL,
    [GrantinfoID]  INT      NOT NULL,
    [LkYear]       INT      NOT NULL,
    [Amount]       MONEY    NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_GrantinfoFYAmt_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_GrantinfoFYAmt_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_GrantinfoFYAmt] PRIMARY KEY CLUSTERED ([GrantInfoFY] ASC),
    CONSTRAINT [FK_GrantinfoFYAmt_GrantInfo] FOREIGN KEY ([GrantinfoID]) REFERENCES [dbo].[GrantInfo] ([GrantinfoID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkYear for Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt', @level2type = N'COLUMN', @level2name = N'LkYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'GrantInfo Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt', @level2type = N'COLUMN', @level2name = N'GrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'RecordID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt', @level2type = N'COLUMN', @level2name = N'GrantInfoFY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grantinfo Fiscal Year link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantinfoFYAmt';

