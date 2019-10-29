CREATE TABLE [dbo].[Trans] (
    [TransId]           INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]         INT            NULL,
    [ProjectCheckReqID] INT            NULL,
    [Date]              DATE           NOT NULL,
    [TransAmt]          MONEY          NOT NULL,
    [PayeeApplicant]    INT            NULL,
    [LkTransaction]     INT            NULL,
    [LkStatus]          INT            NULL,
    [ReallAssignAmt]    MONEY          NULL,
    [UserID]            INT            NULL,
    [Comment]           NVARCHAR (200) NULL,
    [MasterAssign]      BIT            CONSTRAINT [DF_Trans_MasterAssign] DEFAULT ((0)) NOT NULL,
    [Balanced]          BIT            NULL,
    [Adjust]            BIT            CONSTRAINT [DF_Trans_Adjust] DEFAULT ((0)) NOT NULL,
    [RowIsActive]       BIT            CONSTRAINT [DF_TransBoard_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME       CONSTRAINT [DF_TransBoard_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Trans] PRIMARY KEY CLUSTERED ([TransId] ASC),
    CONSTRAINT [FK_Trans_ProjectCheckReq] FOREIGN KEY ([ProjectCheckReqID]) REFERENCES [dbo].[ProjectCheckReq] ([ProjectCheckReqID]) ON DELETE CASCADE
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction Status record ID lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'LkStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkTransaction-FV', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'LkTransaction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ProjectApplicant Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'PayeeApplicant';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction Amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'TransAmt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Transaction Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-ProjectCheckReq table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans', @level2type = N'COLUMN', @level2name = N'TransId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trans Financial table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Trans';

