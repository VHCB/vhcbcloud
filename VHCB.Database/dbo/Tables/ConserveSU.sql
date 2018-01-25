CREATE TABLE [dbo].[ConserveSU] (
    [ConserveSUID]   INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]     INT      NOT NULL,
    [LKBudgetPeriod] INT      NOT NULL,
    [MostCurrent]    BIT      CONSTRAINT [DF_ConserveSU_MostCurrent] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME NOT NULL,
    CONSTRAINT [PK_ConserveSU] PRIMARY KEY CLUSTERED ([ConserveSUID] ASC)
);

