CREATE TYPE [dbo].[QuestionAnswers] AS TABLE (
    [ACPerformanceMasterID] INT            NOT NULL,
    [Response]              NVARCHAR (MAX) NULL,
    [UserID]                INT            NOT NULL,
    [IsCompleted]           BIT            NULL,
    [RowIsActive]           BIT            NULL);

