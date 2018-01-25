CREATE TABLE [dbo].[LkFundType] (
    [TypeId]       INT           IDENTITY (1, 1) NOT NULL,
    [Description]  NVARCHAR (20) NOT NULL,
    [LkSource]     INT           NOT NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_LkFundType_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_FundType_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FundType] PRIMARY KEY CLUSTERED ([TypeId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFundType', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Source-lookup to Lksource-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFundType', @level2type = N'COLUMN', @level2name = N'LkSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFundType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFundType', @level2type = N'COLUMN', @level2name = N'TypeId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fund Types lookup in Fund', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFundType';

