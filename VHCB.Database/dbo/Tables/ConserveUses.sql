CREATE TABLE [dbo].[ConserveUses] (
    [ConserveUsesID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveSUID]   INT      NOT NULL,
    [LkConUseVHCB]   INT      NOT NULL,
    [VHCBTotal]      MONEY    NULL,
    [LkConUseOther]  INT      NOT NULL,
    [OtherTotal]     MONEY    NULL,
    [RowIsActive]    BIT      CONSTRAINT [DF_ConserveUses_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME CONSTRAINT [DF_ConserveUses_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveUses] PRIMARY KEY CLUSTERED ([ConserveUsesID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total $ Amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'VHCBTotal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkConUse', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'LkConUseVHCB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-ConserveSU', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'ConserveSUID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses', @level2type = N'COLUMN', @level2name = N'ConserveUsesID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Project Uses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveUses';

