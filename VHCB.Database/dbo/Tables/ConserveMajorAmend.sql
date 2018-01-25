CREATE TABLE [dbo].[ConserveMajorAmend] (
    [ConserveMajAmendID] INT             IDENTITY (1, 1) NOT NULL,
    [ConserveID]         INT             NOT NULL,
    [LkConsMajAmend]     INT             NOT NULL,
    [ReqDate]            DATE            NULL,
    [LkDisp]             INT             NULL,
    [DispDate]           DATE            NULL,
    [Comments]           NVARCHAR (MAX)  NULL,
    [URL]                NVARCHAR (1500) NULL,
    [RowIsActive]        BIT             CONSTRAINT [DF_StewardLkMajorAmend_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME        CONSTRAINT [DF_StewardLkMajorAmend_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveMajorAmend] PRIMARY KEY CLUSTERED ([ConserveMajAmendID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disposition Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'DispDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkDisp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'LkDisp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Request Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'ReqDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkConsMajorAmend lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'LkConsMajAmend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend', @level2type = N'COLUMN', @level2name = N'ConserveMajAmendID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link Table - Steward-LkMajorAmend', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveMajorAmend';

