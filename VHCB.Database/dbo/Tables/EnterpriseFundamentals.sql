CREATE TABLE [dbo].[EnterpriseFundamentals] (
    [EnterFundamentalID] INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]          INT            NOT NULL,
    [FiscalYr]           INT            NULL,
    [PlanType]           INT            NULL,
    [ServiceProvOrg]     INT            NULL,
    [LeadAdvisor]        INT            NULL,
    [ProjDesc]           NVARCHAR (MAX) NULL,
    [BusDesc]            NVARCHAR (MAX) NULL,
    [RowIsActive]        BIT            CONSTRAINT [DF_EnterpriseFundamentals_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME       CONSTRAINT [DF_EnterpriseFundamentals_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseFundamentals] PRIMARY KEY CLUSTERED ([EnterFundamentalID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Service Provider Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseFundamentals', @level2type = N'COLUMN', @level2name = N'LeadAdvisor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SP Organization', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseFundamentals', @level2type = N'COLUMN', @level2name = N'ServiceProvOrg';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of Plan', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseFundamentals', @level2type = N'COLUMN', @level2name = N'PlanType';

