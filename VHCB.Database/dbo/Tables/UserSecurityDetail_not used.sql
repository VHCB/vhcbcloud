CREATE TABLE [dbo].[UserSecurityDetail_not used] (
    [UserSecurityDetailID] INT           NOT NULL,
    [UserGroupID]          INT           NULL,
    [PageException]        NVARCHAR (50) NULL,
    [FieldException]       NVARCHAR (50) NULL,
    [PageSecurity]         INT           NULL,
    [FieldSecurity]        INT           NULL,
    [RowIsActive]          BIT           CONSTRAINT [DF_UserSecurityDetail_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME      CONSTRAINT [DF_UserSecurityDetail_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserSecurityDetail] PRIMARY KEY CLUSTERED ([UserSecurityDetailID] ASC),
    CONSTRAINT [FK_UserSecurityDetail_UserSecurityGroup] FOREIGN KEY ([UserGroupID]) REFERENCES [dbo].[UserSecurityGroup] ([UserGroupId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityDetail_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSecurityDetail_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';

