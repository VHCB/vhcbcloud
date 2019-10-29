CREATE TABLE [dbo].[ConserveBuffer_not used] (
    [ConserveBufferID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]       INT      NOT NULL,
    [LkBuffer]         INT      NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_ConserveLkBuffer_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_ConserveLkBuffer_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveBuffer] PRIMARY KEY CLUSTERED ([ConserveBufferID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkBuffer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used', @level2type = N'COLUMN', @level2name = N'LkBuffer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Conserve', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used', @level2type = N'COLUMN', @level2name = N'ConserveBufferID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation link to LkBuffer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveBuffer_not used';

