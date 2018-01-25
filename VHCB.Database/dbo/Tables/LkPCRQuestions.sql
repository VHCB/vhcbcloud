CREATE TABLE [dbo].[LkPCRQuestions] (
    [TypeID]       INT            IDENTITY (1, 1) NOT NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [Def]          BIT            CONSTRAINT [DF_LkPCRQuestions_Def] DEFAULT ((0)) NOT NULL,
    [qorder]       INT            NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_LkPCRQuestions_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_LkPCRQuestions_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkPCRQuestions] PRIMARY KEY CLUSTERED ([TypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default question, i.e., always ask', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions', @level2type = N'COLUMN', @level2name = N'Def';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description - MAX', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions', @level2type = N'COLUMN', @level2name = N'TypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Check Request Questions lookup to PCRQuestions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkPCRQuestions';

