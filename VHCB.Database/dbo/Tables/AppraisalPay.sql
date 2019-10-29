CREATE TABLE [dbo].[AppraisalPay] (
    [AppraisalPayID]  INT      IDENTITY (1, 1) NOT NULL,
    [AppraisalInfoID] INT      NOT NULL,
    [PayAmt]          MONEY    NOT NULL,
    [WhoPaid]         INT      NOT NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_AppraisalPay_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_AppraisalPay_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AppraisalPay] PRIMARY KEY CLUSTERED ([AppraisalPayID] ASC),
    CONSTRAINT [FK_AppraisalPay_Appraisals] FOREIGN KEY ([AppraisalInfoID]) REFERENCES [dbo].[AppraisalInfo] ([AppraisalInfoID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who Paid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay', @level2type = N'COLUMN', @level2name = N'WhoPaid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amount Paid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay', @level2type = N'COLUMN', @level2name = N'PayAmt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraisal Info record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay', @level2type = N'COLUMN', @level2name = N'AppraisalInfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay', @level2type = N'COLUMN', @level2name = N'AppraisalPayID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraisal payment', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalPay';

