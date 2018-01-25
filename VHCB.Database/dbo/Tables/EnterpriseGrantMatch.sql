CREATE TABLE [dbo].[EnterpriseGrantMatch] (
    [EnterpriseGrantMatchID] INT      IDENTITY (1, 1) NOT NULL,
    [EnterImpGrantID]        INT      NOT NULL,
    [MatchDescID]            INT      NOT NULL,
    [GrantAmt]               MONEY    NULL,
    [RowIsActive]            BIT      CONSTRAINT [DF_EnterpriseGrantMatch_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]           DATETIME CONSTRAINT [DF_EnterpriseGrantMatch_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseGrantMatch] PRIMARY KEY CLUSTERED ([EnterpriseGrantMatchID] ASC)
);

