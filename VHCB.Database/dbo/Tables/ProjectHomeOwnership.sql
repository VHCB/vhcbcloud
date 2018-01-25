CREATE TABLE [dbo].[ProjectHomeOwnership] (
    [ProjectHomeOwnershipID] INT      IDENTITY (1, 1) NOT NULL,
    [HomeOwnershipID]        INT      NOT NULL,
    [Owner]                  INT      NULL,
    [LkLender]               INT      NULL,
    [vhfa]                   BIT      NULL,
    [RDLoan]                 BIT      NULL,
    [VHCBGrant]              MONEY    NULL,
    [OwnerApprec]            MONEY    NULL,
    [CapImprove]             MONEY    NULL,
    [PurchaseDate]           DATE     NULL,
    [InitFee]                MONEY    NULL,
    [ResaleFee]              MONEY    NULL,
    [StewFee]                MONEY    NULL,
    [AssistLoan]             MONEY    NULL,
    [RehabLoan]              MONEY    NULL,
    [RowIsActive]            BIT      CONSTRAINT [DF_ProjectHomeOwnership_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]           DATETIME CONSTRAINT [DF_ProjectHomeOwnership_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Rehab Loan', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'RehabLoan';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Assistance Fee', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'AssistLoan';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Stewardship Fee', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'StewFee';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Resale Fee', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'ResaleFee';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fee at Purchase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'InitFee';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Capital Improvements', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'CapImprove';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Owner''s Appreciation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'OwnerApprec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Grant', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'VHCBGrant';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if RDLoan', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'RDLoan';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if VHFA involved', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'vhfa';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lender', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'LkLender';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Owner Name - ApplicantID record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHomeOwnership', @level2type = N'COLUMN', @level2name = N'Owner';

