CREATE TABLE [dbo].[UserSecurityGroup] (
    [UserGroupId]    INT            IDENTITY (1, 1) NOT NULL,
    [UserId]         INT            NULL,
    [UserGroupLevel] INT            NOT NULL,
    [UserGroupName]  NVARCHAR (100) NOT NULL,
    [RowIsActive]    BIT            CONSTRAINT [DF_UserGroup_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME       CONSTRAINT [DF_UserGroup_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED ([UserGroupId] ASC),
    CONSTRAINT [FK_UserSecurityGroup_UserInfo] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserInfo] ([UserId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User group name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup', @level2type = N'COLUMN', @level2name = N'UserGroupName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User group level', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup', @level2type = N'COLUMN', @level2name = N'UserGroupLevel';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup', @level2type = N'COLUMN', @level2name = N'UserGroupId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User Group info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityGroup';

