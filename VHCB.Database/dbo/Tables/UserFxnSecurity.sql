CREATE TABLE [dbo].[UserFxnSecurity] (
    [UserFxnSecurityId] INT      IDENTITY (1, 1) NOT NULL,
    [UserID]            INT      NOT NULL,
    [FxnID]             INT      NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_UserFxnSecurity_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_UserFxnSecurity_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserFxnSecurity] PRIMARY KEY CLUSTERED ([UserFxnSecurityId] ASC)
);

