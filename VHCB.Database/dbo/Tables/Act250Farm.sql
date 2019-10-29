CREATE TABLE [dbo].[Act250Farm] (
    [Act250FarmID]   INT             IDENTITY (1, 1) NOT NULL,
    [UsePermit]      NVARCHAR (12)   NULL,
    [LkTownDev]      INT             NULL,
    [CDist]          INT             NULL,
    [Type]           INT             NOT NULL,
    [DevName]        NVARCHAR (50)   NULL,
    [Primelost]      INT             NULL,
    [Statelost]      INT             NULL,
    [TotalAcreslost] INT             NULL,
    [AcresDevelop]   NCHAR (10)      NULL,
    [Developer]      INT             NULL,
    [AntFunds]       MONEY           NULL,
    [MitDate]        DATE            NULL,
    [URL]            NVARCHAR (1500) NULL,
    [RowIsActive]    BIT             CONSTRAINT [DF_Act250Farm_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME        CONSTRAINT [DF_Act250Farm_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Act250Farm] PRIMARY KEY CLUSTERED ([Act250FarmID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mitigation Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'MitDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Anticipated Funds', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'AntFunds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Developer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'Developer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Acres Developed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'AcresDevelop';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Acres Lost to Development', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'TotalAcreslost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State soil acres lost', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'Statelost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Prime soils acres lost', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'Primelost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Either Agriculture or Forestry', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'Type';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'District Commission #-from TownCounty', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'CDist';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town of Development', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'LkTownDev';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Land use permit #', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'UsePermit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm', @level2type = N'COLUMN', @level2name = N'Act250FarmID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Act250Farm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Farm';

