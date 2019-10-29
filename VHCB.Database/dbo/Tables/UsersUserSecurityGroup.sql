CREATE TABLE [dbo].[UsersUserSecurityGroup] (
    [UsersUserSecurityGrpId] INT  IDENTITY (1, 1) NOT NULL,
    [UserId]                 INT  NOT NULL,
    [UserGroupId]            INT  NOT NULL,
    [IsActive]               BIT  CONSTRAINT [DF_UsersUserSecurityGroup_IsActive] DEFAULT ((1)) NOT NULL,
    [DateModifiedBy]         DATE CONSTRAINT [DF_UsersUserSecurityGroup_DateModifiedBy] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UsersUserSecurityGroup] PRIMARY KEY CLUSTERED ([UsersUserSecurityGrpId] ASC),
    CONSTRAINT [FK_UsersUserSecurityGroup_UserInfo] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserInfo] ([UserId]),
    CONSTRAINT [FK_UsersUserSecurityGroup_UserSecurityGroup] FOREIGN KEY ([UserGroupId]) REFERENCES [dbo].[UserSecurityGroup] ([UserGroupId])
);

