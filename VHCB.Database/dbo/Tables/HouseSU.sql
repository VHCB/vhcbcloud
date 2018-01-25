CREATE TABLE [dbo].[HouseSU] (
    [HouseSUID]      INT      IDENTITY (1, 1) NOT NULL,
    [LkBudgetPeriod] INT      NOT NULL,
    [HousingId]      INT      NULL,
    [MostCurrent]    BIT      CONSTRAINT [DF_HouseSU_Default] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME CONSTRAINT [DF_HouseSU_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HouseSU] PRIMARY KEY CLUSTERED ([HouseSUID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSU', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data entered', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSU', @level2type = N'COLUMN', @level2name = N'LkBudgetPeriod';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record index-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSU', @level2type = N'COLUMN', @level2name = N'HouseSUID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing Sources and Uses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSU';

