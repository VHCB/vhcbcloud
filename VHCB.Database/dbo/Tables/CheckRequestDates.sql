CREATE TABLE [dbo].[CheckRequestDates] (
    [CRDateID]     INT      IDENTITY (1, 1) NOT NULL,
    [CRDate]       DATE     NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_CheckRequestDates_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_CheckRequestDates_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20160126-135907]
    ON [dbo].[CheckRequestDates]([CRDateID] ASC)
    INCLUDE([CRDate]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CheckRequestDates', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CheckRequestDates', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Check Request Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CheckRequestDates', @level2type = N'COLUMN', @level2name = N'CRDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CheckRequestDates', @level2type = N'COLUMN', @level2name = N'CRDateID';

