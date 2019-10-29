CREATE TABLE [dbo].[HouseUse] (
    [HouseUseID]      INT      IDENTITY (1, 1) NOT NULL,
    [HouseSUID]       INT      NOT NULL,
    [LkHouseUseVHCB]  INT      NOT NULL,
    [VHCBTotal]       MONEY    NULL,
    [LKHouseUseOther] INT      NULL,
    [OtherTotal]      MONEY    NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_HouseUse_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_HouseUse_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HouseUse] PRIMARY KEY CLUSTERED ([HouseUseID] ASC),
    CONSTRAINT [FK_HouseUse_HouseSU] FOREIGN KEY ([HouseSUID]) REFERENCES [dbo].[HouseSU] ([HouseSUID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse', @level2type = N'COLUMN', @level2name = N'VHCBTotal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkSUuse', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse', @level2type = N'COLUMN', @level2name = N'LkHouseUseVHCB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse', @level2type = N'COLUMN', @level2name = N'HouseSUID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse', @level2type = N'COLUMN', @level2name = N'HouseUseID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing Uses and amounts', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HouseUse';

