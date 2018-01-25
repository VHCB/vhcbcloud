CREATE TABLE [dbo].[CountyTown] (
    [CountyTownID] INT            IDENTITY (1, 1) NOT NULL,
    [county]       NVARCHAR (255) NULL,
    [town]         NVARCHAR (255) NULL,
    [CountyID]     INT            NULL,
    [TownID]       INT            NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_CountyTown_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CountyTown] PRIMARY KEY CLUSTERED ([CountyTownID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date lasty modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'TownID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'CountyID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'town';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'county';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown', @level2type = N'COLUMN', @level2name = N'CountyTownID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Towns with Associated County', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyTown';

