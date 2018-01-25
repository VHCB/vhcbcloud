CREATE TABLE [dbo].[HOPWARace] (
    [HOPWARaceID]  INT      IDENTITY (1, 1) NOT NULL,
    [HOPWAID]      INT      NOT NULL,
    [Race]         INT      NULL,
    [HouseholdNum] INT      NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_HOPWARace_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_HOPWARace_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWARace] PRIMARY KEY CLUSTERED ([HOPWARaceID] ASC),
    CONSTRAINT [FK_HOPWARace_HOPWAMaster] FOREIGN KEY ([HOPWAID]) REFERENCES [dbo].[HOPWAMaster] ([HOPWAID])
);

