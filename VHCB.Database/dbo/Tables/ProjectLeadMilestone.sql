CREATE TABLE [dbo].[ProjectLeadMilestone] (
    [LeadMilestoneID] INT             IDENTITY (1, 1) NOT NULL,
    [ProjectID]       INT             NOT NULL,
    [LKMilestone]     INT             NOT NULL,
    [LeadBldgID]      INT             NOT NULL,
    [LeadUnitID]      INT             NULL,
    [MSDate]          DATE            NOT NULL,
    [URL]             NVARCHAR (1500) NULL,
    [RowIsActive]     BIT             CONSTRAINT [DF_ProjectLeadMilestone_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME        CONSTRAINT [DF_ProjectLeadMilestone_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLeadMilestone] PRIMARY KEY CLUSTERED ([LeadMilestoneID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Milestone Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'MSDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'LeadBldgID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Milestone index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'LKMilestone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Lead primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadMilestone', @level2type = N'COLUMN', @level2name = N'ProjectID';

