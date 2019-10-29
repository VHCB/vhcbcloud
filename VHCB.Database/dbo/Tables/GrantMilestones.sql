CREATE TABLE [dbo].[GrantMilestones] (
    [MilestoneGrantID] INT             IDENTITY (1, 1) NOT NULL,
    [GrantInfoID]      INT             NOT NULL,
    [MilestoneID]      INT             NOT NULL,
    [Date]             DATE            NOT NULL,
    [Note]             NVARCHAR (MAX)  NULL,
    [URL]              NVARCHAR (1500) NULL,
    [RowIsActive]      BIT             CONSTRAINT [DF_GrantMilestones_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME        CONSTRAINT [DF_GrantMilestones_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_GrantMilestones] PRIMARY KEY CLUSTERED ([MilestoneGrantID] ASC)
);

