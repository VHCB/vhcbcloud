CREATE TABLE [dbo].[Act250DevPay] (
    [Act250PayID]  INT           IDENTITY (1, 1) NOT NULL,
    [Act250FarmID] INT           NULL,
    [AmtRec]       MONEY         NULL,
    [DateRec]      DATETIME      NULL,
    [Units]        NVARCHAR (50) NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_Act250DevPay_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Act250DevPay_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Act250DevPay] PRIMARY KEY CLUSTERED ([Act250PayID] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date $ received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay', @level2type = N'COLUMN', @level2name = N'DateRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amount $ received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay', @level2type = N'COLUMN', @level2name = N'AmtRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay', @level2type = N'COLUMN', @level2name = N'Act250PayID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Act250 Developer Payments', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250DevPay';

