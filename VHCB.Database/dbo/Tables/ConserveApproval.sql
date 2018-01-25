CREATE TABLE [dbo].[ConserveApproval] (
    [ConserveApprovalID] INT             IDENTITY (1, 1) NOT NULL,
    [ConserveID]         INT             NOT NULL,
    [LKApproval]         INT             NOT NULL,
    [ReqDate]            DATE            NULL,
    [LKDisp]             INT             NULL,
    [DispDate]           DATE            NOT NULL,
    [Comments]           NVARCHAR (MAX)  NULL,
    [URL]                NVARCHAR (1500) NULL,
    [RowIsActive]        BIT             CONSTRAINT [DF_ConserveApproval_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME        CONSTRAINT [DF_ConserveApproval_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveApproval] PRIMARY KEY CLUSTERED ([ConserveApprovalID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disposition Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveApproval', @level2type = N'COLUMN', @level2name = N'DispDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disposition', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveApproval', @level2type = N'COLUMN', @level2name = N'LKDisp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Request Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveApproval', @level2type = N'COLUMN', @level2name = N'ReqDate';

