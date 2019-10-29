CREATE TABLE [dbo].[HOPWAExp] (
    [HOPWAExpID]         INT      IDENTITY (1, 1) NOT NULL,
    [HOPWAProgramID]     INT      NOT NULL,
    [Fund]               INT      NULL,
    [Amount]             MONEY    NULL,
    [Rent]               BIT      CONSTRAINT [DF_HOPWAExp_Rent] DEFAULT ((0)) NOT NULL,
    [Mortgage]           BIT      CONSTRAINT [DF_HOPWAExp_Mortgage] DEFAULT ((0)) NOT NULL,
    [Utilities]          BIT      CONSTRAINT [DF_HOPWAExp_Utilities] DEFAULT ((0)) NOT NULL,
    [PHPUse]             INT      NULL,
    [Date]               DATE     NULL,
    [DisbursementRecord] INT      NULL,
    [RowIsActive]        BIT      CONSTRAINT [DF_HOPWAExp_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME CONSTRAINT [DF_HOPWAExp_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWAExp] PRIMARY KEY CLUSTERED ([HOPWAExpID] ASC),
    CONSTRAINT [FK_HOPWAExp_HOPWAProgram] FOREIGN KEY ([HOPWAProgramID]) REFERENCES [dbo].[HOPWAProgram] ([HOPWAProgramID])
);

