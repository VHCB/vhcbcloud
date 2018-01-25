CREATE TABLE [dbo].[ConserveFrontage] (
    [ConserveFrontID] INT            IDENTITY (1, 1) NOT NULL,
    [ConserveID]      INT            NOT NULL,
    [LKfrontage]      INT            NOT NULL,
    [Frontage]        INT            NOT NULL,
    [Notes]           NVARCHAR (MAX) NULL,
    [LKWatershed]     INT            NULL,
    [SubWatershed]    NVARCHAR (50)  NULL,
    [RowIsActive]     BIT            CONSTRAINT [DF_ConserveFrontage_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME       CONSTRAINT [DF_ConserveFrontage_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveFrontage] PRIMARY KEY CLUSTERED ([ConserveFrontID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Frontage feet', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'Frontage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Water Frontage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'LKfrontage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveFrontage', @level2type = N'COLUMN', @level2name = N'ConserveFrontID';

