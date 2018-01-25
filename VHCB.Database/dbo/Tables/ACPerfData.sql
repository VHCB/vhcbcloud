CREATE TABLE [dbo].[ACPerfData] (
    [ACPerfDataID]          INT            IDENTITY (1, 1) NOT NULL,
    [ACPerformanceMasterID] INT            NOT NULL,
    [Response]              NVARCHAR (MAX) NULL,
    [UserID]                INT            NOT NULL,
    [IsCompleted]           BIT            CONSTRAINT [DF_ACPerfData_IsCompleted] DEFAULT ((0)) NOT NULL,
    [RowIsActive]           BIT            CONSTRAINT [DF_ACPerfData_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]          DATETIME       CONSTRAINT [DF_ACPerfData_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACPerfData] PRIMARY KEY CLUSTERED ([ACPerfDataID] ASC)
);

