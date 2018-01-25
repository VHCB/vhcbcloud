CREATE TABLE [dbo].[TownCounty] (
    [TownCountyID] INT           IDENTITY (1, 1) NOT NULL,
    [Town]         NVARCHAR (50) NOT NULL,
    [LkTown]       INT           NULL,
    [VillageID]    INT           NULL,
    [LkCounty]     INT           NOT NULL,
    [Zip]          VARCHAR (10)  NULL,
    [State]        NVARCHAR (2)  NOT NULL,
    [District#]    NVARCHAR (2)  NULL,
    [latitude]     FLOAT (53)    NULL,
    [longitude]    FLOAT (53)    NULL,
    [Country]      NVARCHAR (2)  CONSTRAINT [DF_TownCounty_Country] DEFAULT (N'US') NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_TownVillageCnty_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TownVillageCnty] PRIMARY KEY CLUSTERED ([TownCountyID] ASC),
    CONSTRAINT [FK_TownCounty_Village] FOREIGN KEY ([VillageID]) REFERENCES [dbo].[Village] ([VillageID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Country', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'Country';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'District #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'District#';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zip Code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'Zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to County', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'LkCounty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkTown record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'LkTown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'Town';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TownID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty', @level2type = N'COLUMN', @level2name = N'TownCountyID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town/County Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TownCounty';

