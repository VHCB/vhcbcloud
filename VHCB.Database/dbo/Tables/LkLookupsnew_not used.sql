CREATE TABLE [dbo].[LkLookupsnew_not used] (
    [RecordID]      INT            NOT NULL,
    [Tablename]     NVARCHAR (25)  NOT NULL,
    [Viewname]      NVARCHAR (40)  NOT NULL,
    [LKDescription] NVARCHAR (MAX) NULL,
    [Standard]      BIT            NOT NULL,
    [RowIsActive]   BIT            NOT NULL,
    [DateModified]  DATETIME       NOT NULL
);

