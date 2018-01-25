CREATE TABLE [dbo].[ACDefaults] (
    [ACDefaultID]  INT      IDENTITY (1, 1) NOT NULL,
    [YearQtr]      INT      NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_ACDefaults_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_ACDefaults_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACDefaults] PRIMARY KEY CLUSTERED ([ACDefaultID] ASC)
);

