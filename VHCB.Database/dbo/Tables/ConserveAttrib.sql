CREATE TABLE [dbo].[ConserveAttrib] (
    [ConserveAttribID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]       INT      NOT NULL,
    [LkConsAttrib]     INT      NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_ProjectAttrib_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_ProjectAttrib_datemodified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveAttrib_1] PRIMARY KEY CLUSTERED ([ConserveAttribID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation Attributes-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib', @level2type = N'COLUMN', @level2name = N'LkConsAttrib';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib', @level2type = N'COLUMN', @level2name = N'ConserveAttribID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link between Conservation and Attributes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAttrib';

