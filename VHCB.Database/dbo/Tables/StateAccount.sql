CREATE TABLE [dbo].[StateAccount] (
    [TranstateID]  INT           IDENTITY (1, 1) NOT NULL,
    [LkTransType]  INT           NOT NULL,
    [StateAcctnum] NVARCHAR (10) NOT NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_LkStateAccount_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_StateAccount_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LkStateAccount] PRIMARY KEY CLUSTERED ([TranstateID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StateAccount', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StateAccount', @level2type = N'COLUMN', @level2name = N'TranstateID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'FundLGStateID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StateAccount';

