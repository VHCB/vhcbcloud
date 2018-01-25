CREATE TABLE [dbo].[UserInfo] (
    [UserId]          INT           IDENTITY (1, 1) NOT NULL,
    [Fname]           NCHAR (20)    NULL,
    [Lname]           NCHAR (25)    NULL,
    [Username]        NVARCHAR (50) NULL,
    [password]        NVARCHAR (20) NULL,
    [DBConnection]    INT           NULL,
    [email]           NVARCHAR (75) NULL,
    [question1]       NVARCHAR (75) NULL,
    [Answer1]         NVARCHAR (50) NULL,
    [DfltPrg]         INT           NULL,
    [securityLevel]   INT           CONSTRAINT [DF_UserInfo_securityLevel] DEFAULT ((3)) NOT NULL,
    [IsFirstTimeUser] BIT           CONSTRAINT [DF__UserInfo__IsFirs__66E41C5C] DEFAULT ((1)) NULL,
    [NumbProj]        INT           CONSTRAINT [DF_UserInfo_NumbProj] DEFAULT ((0)) NOT NULL,
    [HostSite]        INT           NULL,
    [RowIsActive]     BIT           CONSTRAINT [DF_UserInfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME      CONSTRAINT [DF_UserInfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last Modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of projects accessed - if 0, then not used-connect to UserProject', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'NumbProj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default program-used for default home page presentation-Lkprogram', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'DfltPrg';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Security answer #1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'Answer1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Security question #1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'question1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Email Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'email';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Password', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'password';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Login name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'Username';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'Lname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'First Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'Fname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo', @level2type = N'COLUMN', @level2name = N'UserId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User Info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserInfo';

