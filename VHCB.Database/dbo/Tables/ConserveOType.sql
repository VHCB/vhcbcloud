CREATE TABLE [dbo].[ConserveOType] (
    [ConserveOTypeID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]      INT      NOT NULL,
    [LKOType]         INT      NOT NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_ConserveOType_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_ConserveOType_DateModified] DEFAULT (getdate()) NOT NULL
);

