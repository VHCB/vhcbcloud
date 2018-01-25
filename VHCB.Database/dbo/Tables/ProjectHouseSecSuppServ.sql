CREATE TABLE [dbo].[ProjectHouseSecSuppServ] (
    [ProjectSecSuppServID] INT      IDENTITY (1, 1) NOT NULL,
    [HousingID]            INT      NOT NULL,
    [LKSecSuppServ]        INT      NOT NULL,
    [Numunits]             INT      NOT NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_ProjectHouseSecSuppServ_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_ProjectHouseSecSuppServ_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to recordID=188', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'LKSecSuppServ';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSecSuppServ', @level2type = N'COLUMN', @level2name = N'ProjectSecSuppServID';

