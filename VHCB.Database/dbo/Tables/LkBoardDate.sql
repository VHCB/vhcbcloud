CREATE TABLE [dbo].[LkBoardDate] (
    [TypeID]       INT           IDENTITY (1, 1) NOT NULL,
    [BoardDate]    DATE          NOT NULL,
    [MeetingType]  NVARCHAR (50) NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_LkBoardDate_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkBoardDate] PRIMARY KEY CLUSTERED ([TypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkBoardDate', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Board Meeting Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkBoardDate', @level2type = N'COLUMN', @level2name = N'BoardDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkBoardDate', @level2type = N'COLUMN', @level2name = N'TypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Board Meeting Dates', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LkBoardDate';

