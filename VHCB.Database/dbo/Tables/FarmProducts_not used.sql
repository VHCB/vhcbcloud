CREATE TABLE [dbo].[FarmProducts_not used] (
    [FarmProductsID] INT      NOT NULL,
    [FarmID]         INT      NOT NULL,
    [LkProductCrop]  INT      NOT NULL,
    [StartDate]      DATE     NULL,
    [RowIsActive]    BIT      NOT NULL,
    [DateModified]   DATETIME NOT NULL
);

