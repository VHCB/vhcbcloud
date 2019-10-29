CREATE TABLE [dbo].[ProjectCheckReq] (
    [ProjectCheckReqID] INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]         INT            NULL,
    [Final]             BIT            CONSTRAINT [DF_ProjectCheckReq_Final] DEFAULT ((0)) NULL,
    [Voucher#]          NVARCHAR (10)  NULL,
    [InitDate]          DATE           NULL,
    [Paiddate]          DATE           NULL,
    [LkProgram]         INT            NULL,
    [LegalReview]       BIT            NULL,
    [MatchAmt]          MONEY          NULL,
    [LkFVGrantMatch]    INT            NULL,
    [Notes]             NVARCHAR (MAX) NULL,
    [LCB]               BIT            NULL,
    [FedDrawdown]       BIT            CONSTRAINT [DF_ProjectCheckReq_FedDrawdown] DEFAULT ((0)) NULL,
    [Locked]            BIT            NULL,
    [Coordinator]       INT            NULL,
    [CRDate]            DATE           NULL,
    [RowVersion]        ROWVERSION     NOT NULL,
    [CreatedBy]         INT            NULL,
    [AllApproved]       BIT            CONSTRAINT [DF_ProjectCheckReq_AllApproved] DEFAULT ((0)) NOT NULL,
    [UserID]            INT            NULL,
    [Voided]            BIT            CONSTRAINT [DF_ProjectCheckReq_Voided] DEFAULT ((0)) NOT NULL,
    [RowIsActive]       BIT            CONSTRAINT [DF_ProjectCheckReq_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME       CONSTRAINT [DF_ProjectCheckReq_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectCheckReq] PRIMARY KEY CLUSTERED ([ProjectCheckReqID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If Finalized, then lock for no more changes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'Locked';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Federal drawdown completed?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'FedDrawdown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'In Lake Champlain Basin?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'LCB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disbursement Instructions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'Notes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amount eligible for Match', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'MatchAmt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkProgram record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'LkProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Paid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'Paiddate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Voucher Date - Changed to Initiation Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'InitDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Voucher #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'Voucher#';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Final Payment?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'Final';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Check Requests', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReq';

