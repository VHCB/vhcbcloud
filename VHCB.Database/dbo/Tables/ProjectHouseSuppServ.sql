CREATE TABLE [dbo].[ProjectHouseSuppServ] (
    [ProjectSuppServID] INT        IDENTITY (1, 1) NOT NULL,
    [HousingID]         INT        NOT NULL,
    [LkSuppServ]        INT        NOT NULL,
    [Numunits]          INT        CONSTRAINT [DF_ProjectHouseSuppServ_Numunits] DEFAULT ((0)) NOT NULL,
    [RowIsActive]       BIT        CONSTRAINT [DF_ProjectHouseSuppServ_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME   CONSTRAINT [DF_ProjectHouseSuppServ_DateModified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]        ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectHouseSuppServ] PRIMARY KEY CLUSTERED ([ProjectSuppServID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'Numunits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-LkSuppServ-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'LkSuppServ';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HousingID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ', @level2type = N'COLUMN', @level2name = N'ProjectSuppServID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ProjectHouseSuppServ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectHouseSuppServ';

