CREATE TABLE [dbo].[ProjectCheckReqGrantinfo_not used] (
    [ProjectCheckReqGrantinfoID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectCheckReqID]          INT        NOT NULL,
    [GrantinfoID]                INT        NOT NULL,
    [MatchAmt]                   MONEY      CONSTRAINT [DF_ProjectCheckReqGrantinfo_MatchAmt] DEFAULT ((0)) NOT NULL,
    [RowVersion]                 ROWVERSION NOT NULL,
    [UserID]                     INT        NULL,
    [RowIsActive]                BIT        CONSTRAINT [DF_ProjectCheckReqGrantinfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]               DATETIME   CONSTRAINT [DF_ProjectCheckReqGrantinfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectCheckReqGrantinfo] PRIMARY KEY CLUSTERED ([ProjectCheckReqGrantinfoID] ASC),
    CONSTRAINT [FK_ProjectCheckReqGrantinfo_GrantInfo] FOREIGN KEY ([GrantinfoID]) REFERENCES [dbo].[GrantInfo] ([GrantinfoID]),
    CONSTRAINT [FK_ProjectCheckReqGrantinfo_ProjectCheckReq] FOREIGN KEY ([ProjectCheckReqID]) REFERENCES [dbo].[ProjectCheckReq] ([ProjectCheckReqID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Dollar match amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'MatchAmt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID for matching in Grantinfo', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'GrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Check Request record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqGrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ProjectCheckReq Grantinfo link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqGrantinfo_not used';

