CREATE TABLE [dbo].[PCRItems_not used] (
    [PCRItemsID]        INT      NOT NULL,
    [ProjectCheckReqID] INT      NOT NULL,
    [LKPCRItems]        INT      NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_PCRItems_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_PCRItems_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PCRItems] PRIMARY KEY CLUSTERED ([PCRItemsID] ASC)
);

