CREATE TABLE [dbo].[EnterpriseProducts] (
    [EnterpriseProductsID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]            INT      NOT NULL,
    [LkProduct]            INT      NOT NULL,
    [StartDate]            DATE     NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_FarmStatusFVProducts_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_FarmFVProducts_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FarmFVProducts] PRIMARY KEY CLUSTERED ([EnterpriseProductsID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date first started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkFVProductCrop ID record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'LkProduct';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts', @level2type = N'COLUMN', @level2name = N'EnterpriseProductsID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm''s Product(s)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseProducts';

