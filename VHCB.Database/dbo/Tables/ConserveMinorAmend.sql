CREATE TABLE [dbo].[ConserveMinorAmend] (
    [ConserveMinAmendID] INT             IDENTITY (1, 1) NOT NULL,
    [ConserveID]         INT             NOT NULL,
    [LkConsMinAmend]     INT             NOT NULL,
    [ReqDate]            DATE            NULL,
    [LkDisp]             INT             NULL,
    [DispDate]           DATE            NULL,
    [Comments]           NVARCHAR (MAX)  NULL,
    [URL]                NVARCHAR (1500) NULL,
    [RowIsActive]        BIT             CONSTRAINT [DF_StewardMinorAmend_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME        CONSTRAINT [DF_StewardMinorAmend_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveMinorAmend] PRIMARY KEY CLUSTERED ([ConserveMinAmendID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disposition Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'DispDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkDisp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'LkDisp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Request Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'ReqDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkConsMinAmend lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'LkConsMinAmend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend', @level2type = N'COLUMN', @level2name = N'ConserveMinAmendID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link Table - Steward-LkMinorAmend', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMinorAmend';

