CREATE TABLE [dbo].[EnterpriseBusPlanUse] (
    [EnterBusPlanUseID] INT      IDENTITY (1, 1) NOT NULL,
    [EnterpriseEvalID]  INT      NOT NULL,
    [LKBusPlanUsage]    INT      NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_EnterpriseBusPlanUse_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_EnterpriseBusPlanUse_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseBusPlanUse] PRIMARY KEY CLUSTERED ([EnterBusPlanUseID] ASC)
);

