CREATE TABLE [dbo].[ConserveEvent] (
    [ConserveEventID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]      INT      NOT NULL,
    [LKEvent]         INT      NOT NULL,
    [DispDate]        DATE     NOT NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_ConserveEvent_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_ConserveEvent_DateModified] DEFAULT (getdate()) NOT NULL
);

