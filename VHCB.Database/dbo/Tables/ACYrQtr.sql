CREATE TABLE [dbo].[ACYrQtr] (
    [ACYrQtrID] INT IDENTITY (1, 1) NOT NULL,
    [Year]      INT NULL,
    [Qtr]       INT NULL,
    CONSTRAINT [PK_ACYrQtr] PRIMARY KEY CLUSTERED ([ACYrQtrID] ASC)
);

