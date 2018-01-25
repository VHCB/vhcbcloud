CREATE TABLE [dbo].[LkFVStatusPd_not used] (
    [TypeID]       INT           IDENTITY (1, 1) NOT NULL,
    [Description]  NVARCHAR (50) NOT NULL,
    [StatType]     NCHAR (2)     NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_LkFVStatusPd_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkFVStatusPd] PRIMARY KEY CLUSTERED ([TypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFVStatusPd_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Status Type:FD-Fundamental, IG-Imp. Grant, IS-Imp.Services,FE-Farmer Eval', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFVStatusPd_not used', @level2type = N'COLUMN', @level2name = N'StatType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFVStatusPd_not used', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFVStatusPd_not used', @level2type = N'COLUMN', @level2name = N'TypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkFVStatusPd-Periods for Farm Status info lookup to FarmEconStatus', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkFVStatusPd_not used';

