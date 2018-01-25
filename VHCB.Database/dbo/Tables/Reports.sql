CREATE TABLE [dbo].[Reports] (
    [ReportID]     INT           IDENTITY (1, 1) NOT NULL,
    [Folder]       NVARCHAR (75) NULL,
    [ReportName]   NVARCHAR (80) NULL,
    [ViewName]     NVARCHAR (80) NULL,
    [Params]       NVARCHAR (80) NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_Reports_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Reports_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED ([ReportID] ASC)
);

