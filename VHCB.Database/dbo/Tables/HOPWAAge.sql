CREATE TABLE [dbo].[HOPWAAge] (
    [HOPWAAgeId]   INT      IDENTITY (1, 1) NOT NULL,
    [HOPWAID]      INT      NOT NULL,
    [GenderAgeID]  INT      NULL,
    [GANum]        INT      NULL,
    [RowisActive]  BIT      CONSTRAINT [DF_HOPWAAge_RowisActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_HOPWAAge_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWAAge] PRIMARY KEY CLUSTERED ([HOPWAAgeId] ASC),
    CONSTRAINT [FK_HOPWAAge_HOPWAMaster] FOREIGN KEY ([HOPWAID]) REFERENCES [dbo].[HOPWAMaster] ([HOPWAID])
);

