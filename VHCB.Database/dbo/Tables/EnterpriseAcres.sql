CREATE TABLE [dbo].[EnterpriseAcres] (
    [EnterpriseAcresId] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]         INT      NULL,
    [AcresInProduction] INT      NULL,
    [AcresOwned]        INT      NULL,
    [AcresLeased]       INT      NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_Farms_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_Farms_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Farm] PRIMARY KEY CLUSTERED ([EnterpriseAcresId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Acres Leased', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'AcresLeased';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Acres owned', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'AcresOwned';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Acres in production', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'AcresInProduction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres', @level2type = N'COLUMN', @level2name = N'EnterpriseAcresId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farms Master', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAcres';

