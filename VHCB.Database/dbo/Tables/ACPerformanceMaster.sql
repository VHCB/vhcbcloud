CREATE TABLE [dbo].[ACPerformanceMaster] (
    [ACPerformanceMasterID] INT            IDENTITY (1, 1) NOT NULL,
    [ACYrQtrID]             INT            NULL,
    [QuestionNum]           INT            NULL,
    [NumOrder]              INT            NULL,
    [LabelDefinition]       NVARCHAR (MAX) NULL,
    [ResultType]            INT            NULL,
    [RowIsActive]           BIT            CONSTRAINT [DF_ACPerformanceMaster_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]          DATETIME       CONSTRAINT [DF_ACPerformanceMaster_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACPerformanceMaster] PRIMARY KEY CLUSTERED ([ACPerformanceMasterID] ASC)
);

