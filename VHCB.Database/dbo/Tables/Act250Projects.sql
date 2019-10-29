CREATE TABLE [dbo].[Act250Projects] (
    [Act250ProjectID] INT      IDENTITY (1, 1) NOT NULL,
    [Act250FarmID]    INT      NULL,
    [ProjectID]       INT      NOT NULL,
    [LKTownConserve]  INT      NOT NULL,
    [AmtFunds]        MONEY    NOT NULL,
    [DateClosed]      DATE     NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_Act250Projects_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_Act250Projects_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Act250Projects] PRIMARY KEY CLUSTERED ([Act250ProjectID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Closed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'DateClosed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Anticipated Funds', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'AmtFunds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Town of Conservation - lookup to Towns', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'LKTownConserve';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Act250Projects', @level2type = N'COLUMN', @level2name = N'Act250ProjectID';

