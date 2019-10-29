CREATE TABLE [dbo].[UserProject_not used] (
    [UserProjectID] INT      IDENTITY (1, 1) NOT NULL,
    [UserID]        INT      NOT NULL,
    [ProjectID]     INT      NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_UserProject_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserProject] PRIMARY KEY CLUSTERED ([UserProjectID] ASC),
    CONSTRAINT [FK_UserProject_UserInfo] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserInfo] ([UserId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProject_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProject_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProject_not used', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProject_not used', @level2type = N'COLUMN', @level2name = N'UserProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s accessed projects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProject_not used';

