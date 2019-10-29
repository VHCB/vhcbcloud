CREATE TABLE [dbo].[ConservePAccess] (
    [ConservePAcessID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]       INT      NOT NULL,
    [LkPAccess]        INT      NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_ConservePAccess_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_ConservePAccess_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConservePAccess_1] PRIMARY KEY CLUSTERED ([ConservePAcessID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkPAccess lookup-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess', @level2type = N'COLUMN', @level2name = N'LkPAccess';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess', @level2type = N'COLUMN', @level2name = N'ConservePAcessID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Steward Public Access Link', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConservePAccess';

