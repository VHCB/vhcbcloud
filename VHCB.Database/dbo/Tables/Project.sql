CREATE TABLE [dbo].[Project] (
    [ProjectId]     INT            IDENTITY (1, 1) NOT NULL,
    [Proj_num]      VARCHAR (50)   NOT NULL,
    [LkProjectType] INT            NULL,
    [LkProgram]     INT            NULL,
    [AppRec]        DATE           NULL,
    [LkAppStatus]   INT            NULL,
    [Manager]       INT            NULL,
    [Goal]          INT            NULL,
    [LkBoardDate]   INT            NULL,
    [ClosingDate]   DATE           NULL,
    [ExpireDate]    DATE           NULL,
    [verified]      BIT            CONSTRAINT [DF_Project_verified] DEFAULT ((0)) NULL,
    [VerifiedDate]  DATE           NULL,
    [Descrip]       NVARCHAR (MAX) NULL,
    [RowVersion]    ROWVERSION     NOT NULL,
    [userid]        INT            NULL,
    [RowIsActive]   BIT            CONSTRAINT [DF_Project_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME       CONSTRAINT [DF_Project_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED ([ProjectId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20160205-134549]
    ON [dbo].[Project]([Proj_num] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID - used to identify locking issues', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'userid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'used for optimistic locking', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'RowVersion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if verified-update record with form data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'verified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant Expiration Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ExpireDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Closing Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ClosingDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Board meeting Date - LkBoardDate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'LkBoardDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation Goal', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'Goal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Staff responsible for project-Userinfo table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'Manager';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Status - lookup to LkAppStatus', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'LkAppStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application Received date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'AppRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Program', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'LkProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'LkProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'Proj_num';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project master table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';

