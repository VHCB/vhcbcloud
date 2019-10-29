CREATE TABLE [dbo].[ConserveSteward_not used] (
    [ConserveStewardID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]        INT      NOT NULL,
    [LKConserveSteward] INT      NOT NULL,
    [DispDate]          DATE     NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ConserveSteward_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ConserveSteward_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveSteward] PRIMARY KEY CLUSTERED ([ConserveStewardID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSteward_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSteward_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disposition Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSteward_not used', @level2type = N'COLUMN', @level2name = N'DispDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSteward_not used', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveSteward_not used', @level2type = N'COLUMN', @level2name = N'ConserveStewardID';

