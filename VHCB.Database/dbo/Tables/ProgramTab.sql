CREATE TABLE [dbo].[ProgramTab] (
    [ProgramTabID]  INT            IDENTITY (1, 1) NOT NULL,
    [LKVHCBProgram] INT            NOT NULL,
    [TabName]       NVARCHAR (50)  NOT NULL,
    [taborder]      INT            NULL,
    [URL]           NVARCHAR (50)  NOT NULL,
    [PageName]      NVARCHAR (150) NULL,
    [RowIsActive]   BIT            CONSTRAINT [DF_ProgramTab_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME       CONSTRAINT [DF_ProgramTab_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTab', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTab', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LookupType=34', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTab', @level2type = N'COLUMN', @level2name = N'LKVHCBProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTab', @level2type = N'COLUMN', @level2name = N'ProgramTabID';

