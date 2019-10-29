CREATE TABLE [dbo].[ProjectLeadUnit] (
    [LeadUnitID]    INT      IDENTITY (1, 1) NOT NULL,
    [LeadBldgID]    INT      NOT NULL,
    [Unit]          INT      NULL,
    [EBLStatus]     INT      NULL,
    [HHCount]       INT      NULL,
    [Rooms]         INT      NULL,
    [HHIncome]      MONEY    NULL,
    [PartyVerified] BIT      NULL,
    [IncomeStatus]  INT      NULL,
    [MatchFunds]    MONEY    NULL,
    [ClearDate]     DATE     NULL,
    [CertDate]      DATE     NULL,
    [ReCertDate]    DATE     NULL,
    [StartDate]     DATE     NULL,
    [RelocationAmt] MONEY    NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_ProjectLeadOccupant_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_ProjectLeadOccupant_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ReCertify Date - 6 months from CertDate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'ReCertDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Certify Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'CertDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Income Status', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'IncomeStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'3rd party verified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'PartyVerified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HouseHold Income', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'HHIncome';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HouseHold Count', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'HHCount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'EBLStatus', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'EBLStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'Unit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lead Bldg index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadUnit', @level2type = N'COLUMN', @level2name = N'LeadBldgID';

