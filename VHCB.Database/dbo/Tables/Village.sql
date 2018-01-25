CREATE TABLE [dbo].[Village] (
    [VillageID]    INT           IDENTITY (1, 1) NOT NULL,
    [LkTown]       INT           NOT NULL,
    [Village]      NVARCHAR (50) NOT NULL,
    [Zip]          VARCHAR (5)   NULL,
    [Datemodified] DATETIME      CONSTRAINT [DF_Village_Datemodified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Village] PRIMARY KEY CLUSTERED ([VillageID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Village', @level2type = N'COLUMN', @level2name = N'Datemodified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Village Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Village', @level2type = N'COLUMN', @level2name = N'Village';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkTown TypeID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Village', @level2type = N'COLUMN', @level2name = N'LkTown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Village', @level2type = N'COLUMN', @level2name = N'VillageID';

