CREATE TABLE [dbo].[ProjectAssetManage_not used] (
    [ProjectAssetManageID] INT           IDENTITY (1, 1) NOT NULL,
    [ProjectID]            INT           NOT NULL,
    [ApplicantID]          INT           NOT NULL,
    [FromMoYear]           NVARCHAR (10) NULL,
    [ToMoYear]             NVARCHAR (10) NULL,
    [Model]                NVARCHAR (50) NULL,
    [NumBuild]             INT           NULL,
    [NumUnit]              INT           NULL,
    [PotRent]              MONEY         NULL,
    [VacancyLoss]          MONEY         NULL,
    [OtherIncome]          MONEY         NULL,
    [GrossIncome]          MONEY         NULL,
    [OperExp]              MONEY         NULL,
    [NetOperIncome]        MONEY         NULL,
    [DebtServ]             MONEY         NULL,
    [ReplaceRes]           MONEY         NULL,
    [OperBal]              MONEY         NULL,
    [OperRes]              MONEY         NULL,
    CONSTRAINT [PK_ProjectAssetManage] PRIMARY KEY CLUSTERED ([ProjectAssetManageID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAssetManage_not used', @level2type = N'COLUMN', @level2name = N'ProjectAssetManageID';

