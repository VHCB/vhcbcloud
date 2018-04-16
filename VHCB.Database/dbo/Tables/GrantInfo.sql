CREATE TABLE [dbo].[GrantInfo] (
    [GrantinfoID]   INT            IDENTITY (1, 1) NOT NULL,
    [GrantName]     NVARCHAR (50)  NOT NULL,
    [VHCBName]      NVARCHAR (50)  NOT NULL,
    [LkGrantAgency] INT            NULL,
    [LkGrantSource] INT            NULL,
    [Grantor]       NVARCHAR (20)  NULL,
    [Fund]          INT            NULL,
    [AwardNum]      NVARCHAR (25)  NULL,
    [AwardAmt]      MONEY          NULL,
    [BeginDate]     DATETIME       NULL,
    [EndDate]       DATETIME       NULL,
    [Staff]         INT            NULL,
    [ContactID]     INT            NULL,
    [CFDA]          NCHAR (5)      NULL,
    [Program]       INT            NULL,
    [SignAgree]     BIT            NULL,
    [FedFunds]      BIT            NULL,
    [FedSignDate]   DATE           NULL,
    [Fundsrec]      BIT            NULL,
    [DrawDown]      BIT            CONSTRAINT [DF_GrantInfo_DrawDown] DEFAULT ((0)) NOT NULL,
    [Match]         BIT            NULL,
    [MatchAmt]      MONEY          NULL,
    [Admin]         BIT            NULL,
    [AdminAmt]      MONEY          NULL,
    [Notes]         NVARCHAR (MAX) NULL,
    [RowIsActive]   BIT            CONSTRAINT [DF_GrantInfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME       CONSTRAINT [DF_GrantInfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_GrantInfo] PRIMARY KEY CLUSTERED ([GrantinfoID] ASC)
);






GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Notes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'Notes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Admin?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'Admin';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Match', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'Match';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fed Funds?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'FedFunds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Signed Grant Agreement', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'SignAgree';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'CFDA # (XX.XX)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'CFDA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'ContactID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Staff ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'Staff';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'End Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Begin Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'BeginDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Award Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'AwardNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LKGrantor record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'LkGrantAgency';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'VHCBName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'GrantName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID - Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo', @level2type = N'COLUMN', @level2name = N'GrantinfoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant Info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GrantInfo';

