CREATE TABLE [dbo].[ReallocateLink] (
    [ReallocateID]   INT           IDENTITY (1, 1) NOT NULL,
    [FromProjectId]  INT           NOT NULL,
    [FromTransID]    INT           NOT NULL,
    [ToProjectId]    INT           CONSTRAINT [DF_ReallocateLink_ToProjectId] DEFAULT ((0)) NOT NULL,
    [ToTransID]      INT           NOT NULL,
    [ReallocateGUID] VARCHAR (100) NULL,
    [RowIsActive]    BIT           CONSTRAINT [DF_ReallocateLink_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME      CONSTRAINT [DF_ReallocateLink_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ReallocateLink] PRIMARY KEY CLUSTERED ([ReallocateID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ReallocateLink', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ReallocateLink', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction ID #2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ReallocateLink', @level2type = N'COLUMN', @level2name = N'ToTransID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction ID #1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ReallocateLink', @level2type = N'COLUMN', @level2name = N'FromTransID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ReallocateLink', @level2type = N'COLUMN', @level2name = N'ReallocateID';

