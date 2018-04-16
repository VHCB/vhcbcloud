CREATE TABLE [dbo].[Fund] (
    [FundId]       INT            IDENTITY (1, 1) NOT NULL,
    [name]         NVARCHAR (35)  NULL,
    [abbrv]        NVARCHAR (20)  NULL,
    [LkFundType]   INT            NULL,
    [account]      NVARCHAR (4)   NULL,
    [LkAcctMethod] INT            NULL,
    [DeptID]       NVARCHAR (12)  NULL,
    [VHCBCode]     NVARCHAR (25)  NULL,
    [Drawdown]     BIT            NULL,
    [MitFund]      BIT            CONSTRAINT [DF_Fund_MitFund] DEFAULT ((0)) NOT NULL,
    [MIPFundnum]   NUMERIC (4)    NULL,
    [LkProgram]    INT            NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_Fund_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_Fund_DateModified_1] DEFAULT (getdate()) NOT NULL,
    [FundKey]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_Fund_1] PRIMARY KEY CLUSTERED ([FundId] ASC),
    CONSTRAINT [FK_Fund_Fund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[Fund] ([FundId])
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [Account]
    ON [dbo].[Fund]([account] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mitigation Fund', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'MitFund';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Requires Federal Drawdown?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'Drawdown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'VHCBCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Dept. ID #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'DeptID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB internal accounting number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'account';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkFundType-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'LkFundType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fund Abbreviation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'abbrv';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fund Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund', @level2type = N'COLUMN', @level2name = N'FundId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fund Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Fund';

