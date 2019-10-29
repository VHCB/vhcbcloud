CREATE TABLE [dbo].[Housing] (
    [HousingID]     INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]     INT      NOT NULL,
    [LkHouseCat]    INT      NULL,
    [Hsqft]         INT      NULL,
    [TotalUnits]    INT      NULL,
    [Previous]      INT      CONSTRAINT [DF_Housing_Previous] DEFAULT ((0)) NOT NULL,
    [UnitsRemoved]  INT      CONSTRAINT [DF_Housing_UnitsRemoved] DEFAULT ((0)) NOT NULL,
    [NewUnits]      INT      CONSTRAINT [DF_Housing_NewUnits] DEFAULT ((0)) NULL,
    [SASH]          BIT      CONSTRAINT [DF_Housing_SASH] DEFAULT ((0)) NULL,
    [Vermod]        INT      NULL,
    [ServSuppUnits] INT      CONSTRAINT [DF_Housing_ServSuppUnits] DEFAULT ((0)) NOT NULL,
    [AffordUnits]   INT      NULL,
    [Bldgs]         INT      NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_Housing_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_Housing_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Housing] PRIMARY KEY CLUSTERED ([HousingID] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Service Supported Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'ServSuppUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Vermod Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'Vermod';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SASH Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'SASH';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'New Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'NewUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Units from previous project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'Previous';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Units in Project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'TotalUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Gross living area', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'Hsqft';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Main Housing Type project; LookupType=9', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'LkHouseCat';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing', @level2type = N'COLUMN', @level2name = N'HousingID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing Units info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Housing';

