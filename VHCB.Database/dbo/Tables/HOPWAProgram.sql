CREATE TABLE [dbo].[HOPWAProgram] (
    [HOPWAProgramID]    INT            IDENTITY (1, 1) NOT NULL,
    [HOPWAID]           INT            NOT NULL,
    [Program]           INT            NOT NULL,
    [Fund]              INT            NOT NULL,
    [LivingSituationId] INT            NULL,
    [Yr1]               BIT            CONSTRAINT [DF_HOPWAProgram_Yr1] DEFAULT ((0)) NOT NULL,
    [Yr2]               BIT            CONSTRAINT [DF_HOPWAProgram_Yr2] DEFAULT ((0)) NOT NULL,
    [Yr3]               BIT            CONSTRAINT [DF_HOPWAProgram_Yr3] DEFAULT ((0)) NOT NULL,
    [StartDate]         DATE           NULL,
    [EndDate]           DATE           NULL,
    [Notes]             NVARCHAR (MAX) NULL,
    [RowIsactive]       BIT            CONSTRAINT [DF_HOPWAProgram_RowIsactive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME       CONSTRAINT [DF_HOPWAProgram_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWAProgram] PRIMARY KEY CLUSTERED ([HOPWAProgramID] ASC),
    CONSTRAINT [FK_HOPWAProgram_HOPWAMaster] FOREIGN KEY ([HOPWAID]) REFERENCES [dbo].[HOPWAMaster] ([HOPWAID])
);

