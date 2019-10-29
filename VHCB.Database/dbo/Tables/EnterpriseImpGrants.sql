CREATE TABLE [dbo].[EnterpriseImpGrants] (
    [EnterImpGrantID] INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]       INT            NOT NULL,
    [FYGrantRound]    INT            NULL,
    [OtherNames]      NVARCHAR (150) NULL,
    [Milestone]       INT            NULL,
    [ProjTitle]       NVARCHAR (80)  NULL,
    [ProjDesc]        NVARCHAR (MAX) NULL,
    [ProjCost]        MONEY          NULL,
    [Request]         MONEY          NULL,
    [AwardAmt]        MONEY          NULL,
    [AwardDesc]       NVARCHAR (MAX) NULL,
    [LeveragedFunds]  MONEY          NULL,
    [Comments]        NVARCHAR (MAX) NULL,
    [RowIsActive]     BIT            CONSTRAINT [DF_FarmImplementGrants_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME       CONSTRAINT [DF_FarmImplementGrants_DateModified] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_FarmImplementGrants] PRIMARY KEY CLUSTERED ([EnterImpGrantID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Awarded Amount', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'AwardAmt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Amt. requested', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'Request';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project cost', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'ProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'ProjDesc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants', @level2type = N'COLUMN', @level2name = N'EnterImpGrantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm Implementation grant info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseImpGrants';

