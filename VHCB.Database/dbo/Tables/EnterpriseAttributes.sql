CREATE TABLE [dbo].[EnterpriseAttributes] (
    [EnterpriseAttributeID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]             INT      NOT NULL,
    [LKAttributeID]         INT      NOT NULL,
    [Date]                  DATE     NULL,
    [RowIsActive]           BIT      CONSTRAINT [DF_FarmAttributes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]          DATETIME CONSTRAINT [DF_FarmAttributes_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FarmAttributes] PRIMARY KEY CLUSTERED ([EnterpriseAttributeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAttributes', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'IsRowActive', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAttributes', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm attribute index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAttributes', @level2type = N'COLUMN', @level2name = N'LKAttributeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseAttributes', @level2type = N'COLUMN', @level2name = N'ProjectID';

