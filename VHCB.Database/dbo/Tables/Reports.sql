CREATE TABLE [dbo].[Reports] (
    [ReportID]     INT            IDENTITY (1, 1) NOT NULL,
    [Folder]       NVARCHAR (75)  NULL,
    [ReportName]   NVARCHAR (100) NULL,
    [ViewName]     NVARCHAR (100) NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [Params]       NVARCHAR (150) NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_Reports_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_Reports_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED ([ReportID] ASC)
);



