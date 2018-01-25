CREATE TABLE [dbo].[EnterpriseServProviderData] (
    [EnterServiceProvID]            INT            IDENTITY (1, 1) NOT NULL,
    [EnterpriseMasterServiceProvID] INT            NOT NULL,
    [PrePost]                       INT            NOT NULL,
    [BusPlans]                      INT            NULL,
    [BusPlanProjCost]               MONEY          NULL,
    [CashFlows]                     INT            NULL,
    [CashFlowProjCost]              MONEY          NULL,
    [Yr2Followup]                   INT            NULL,
    [Yr2FollowUpProjCost]           MONEY          NULL,
    [AddEnrollees]                  INT            NULL,
    [AddEnrolleeProjCost]           MONEY          NULL,
    [WorkshopsEvents]               INT            NULL,
    [WorkShopEventProjCost]         MONEY          NULL,
    [SpecialProj]                   NVARCHAR (MAX) NULL,
    [Notes]                         NVARCHAR (MAX) NULL,
    [RowIsActive]                   BIT            CONSTRAINT [DF_EnterpriseServProviderData_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]                  DATETIME       CONSTRAINT [DF_EnterpriseServProviderData_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseServProviderData] PRIMARY KEY CLUSTERED ([EnterServiceProvID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Workshops & Events Cost per Project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'WorkShopEventProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of Workshops / Events', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'WorkshopsEvents';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Additional Enrollees cost per project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'AddEnrolleeProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of additional enrollees', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'AddEnrollees';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Year 2 Followup costs per project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'Yr2FollowUpProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of Year 2 Followups', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'Yr2Followup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Cash Flow Cost / Project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'CashFlowProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of Cash Flows', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'CashFlows';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Business Plans cost per project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'BusPlanProjCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of business plans', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'BusPlans';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseServProviderData', @level2type = N'COLUMN', @level2name = N'EnterServiceProvID';

