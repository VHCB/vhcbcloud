CREATE TABLE [dbo].[TransAssign] (
    [TransAssignID] INT      IDENTITY (1, 1) NOT NULL,
    [TransID]       INT      NOT NULL,
    [ToTransID]     INT      NOT NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_TransAssign_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_TransAssign_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TransAssign] PRIMARY KEY CLUSTERED ([TransAssignID] ASC)
);

