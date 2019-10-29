CREATE TABLE [dbo].[LkLender] (
    [LenderId]     INT           IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50) NULL,
    [Abbrev]       NVARCHAR (10) NULL,
    [IsRowActive]  BIT           CONSTRAINT [DF_LkLender_IsRowActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_LkLender_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkLender] PRIMARY KEY CLUSTERED ([LenderId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Row is active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender', @level2type = N'COLUMN', @level2name = N'IsRowActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Abbreviation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender', @level2type = N'COLUMN', @level2name = N'Abbrev';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lender Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender', @level2type = N'COLUMN', @level2name = N'LenderId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lenders-for single family table Not used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkLender';

