CREATE TABLE [dbo].[HouseSource] (
    [HouseSourceID] INT      IDENTITY (1, 1) NOT NULL,
    [HouseSUID]     INT      NOT NULL,
    [LkHouseSource] INT      NOT NULL,
    [Total]         MONEY    NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_HouseSource_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_HouseSource_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HouseSource] PRIMARY KEY CLUSTERED ([HouseSourceID] ASC),
    CONSTRAINT [FK_HouseSource_HouseSU] FOREIGN KEY ([HouseSUID]) REFERENCES [dbo].[HouseSU] ([HouseSUID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total $', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'Total';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkSUSource record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'LkHouseSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'HouseSUID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource', @level2type = N'COLUMN', @level2name = N'HouseSourceID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing Sources and Amts', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseSource';

