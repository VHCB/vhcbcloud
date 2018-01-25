CREATE TABLE [dbo].[ProjectCheckReqItems] (
    [ProjectCheckReqItems] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectCheckReqID]    INT      NOT NULL,
    [LKCRItems]            INT      NOT NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_ProjectCheckReqItems_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_ProjectCheckReqItems_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectCheckReqItems] PRIMARY KEY CLUSTERED ([ProjectCheckReqItems] ASC)
);

