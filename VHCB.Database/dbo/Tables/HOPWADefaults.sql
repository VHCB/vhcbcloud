CREATE TABLE [dbo].[HOPWADefaults] (
    [HOPWADefaultID] INT      IDENTITY (1, 1) NOT NULL,
    [IsCurrent]      BIT      CONSTRAINT [DF_HOPWADefaults_IsCurrent] DEFAULT ((0)) NOT NULL,
    [CurrentFund]    INT      NOT NULL,
    [FundStartDate]  DATE     NULL,
    [FundEndDate]    DATE     NULL,
    [PreviousFund]   INT      NULL,
    [Year]           INT      NULL,
    [STRMUMaxAmt]    MONEY    NULL,
    [RowIsActive]    BIT      CONSTRAINT [DF_HOPWADefaults_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME CONSTRAINT [DF_HOPWADefaults_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWADefaults] PRIMARY KEY CLUSTERED ([HOPWADefaultID] ASC)
);

