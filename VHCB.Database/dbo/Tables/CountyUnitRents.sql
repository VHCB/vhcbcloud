CREATE TABLE [dbo].[CountyUnitRents] (
    [CountyUnitRentID] INT      IDENTITY (1, 1) NOT NULL,
    [CountyRentID]     INT      NOT NULL,
    [UnitType]         INT      NOT NULL,
    [HighRent]         MONEY    NOT NULL,
    [LowRent]          MONEY    NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_CountyUnitRents_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_CountyUnitRents_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CountyUnitRents] PRIMARY KEY CLUSTERED ([CountyUnitRentID] ASC)
);

