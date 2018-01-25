CREATE TABLE [dbo].[LookupProgram_not used] (
    [LkLookupID]   INT      NOT NULL,
    [LkProgram]    INT      NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_LookupProgram_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_LookupProgram_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK__LookupPr__B29B39E07A721B0A] PRIMARY KEY CLUSTERED ([LkLookupID] ASC, [LkProgram] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupProgram_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupProgram_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID Record of LkProgram table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupProgram_not used', @level2type = N'COLUMN', @level2name = N'LkProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID Record of LkLookup table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupProgram_not used', @level2type = N'COLUMN', @level2name = N'LkLookupID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkLookup to LkProgram Link table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupProgram_not used';

