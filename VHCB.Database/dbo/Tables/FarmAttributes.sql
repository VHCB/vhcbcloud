CREATE TABLE [dbo].[FarmAttributes] (
    [FarmAttributeID]   INT      NOT NULL,
    [FarmID]            INT      NOT NULL,
    [LKFarmAttributeID] INT      NOT NULL,
    [RowIsActive]       BIT      NOT NULL,
    [DateModified]      DATETIME NOT NULL
);

