CREATE TABLE [dbo].[ConserveAcres] (
    [ConserveAcresID] INT        IDENTITY (1, 1) NOT NULL,
    [ConserveID]      INT        NOT NULL,
    [LkAcres]         INT        NOT NULL,
    [Acres]           FLOAT (53) CONSTRAINT [DF_ConserveAcres_Acres] DEFAULT ((0)) NOT NULL,
    [RowIsActive]     BIT        CONSTRAINT [DF_ConserveAcres_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME   CONSTRAINT [DF_ConserveAcres_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveAcres] PRIMARY KEY CLUSTERED ([ConserveAcresID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of acres', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres', @level2type = N'COLUMN', @level2name = N'Acres';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkAcres record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres', @level2type = N'COLUMN', @level2name = N'LkAcres';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve-Acres link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAcres';

