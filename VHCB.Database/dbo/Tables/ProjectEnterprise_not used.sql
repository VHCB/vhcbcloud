CREATE TABLE [dbo].[ProjectEnterprise_not used] (
    [ProjectID]       INT           NOT NULL,
    [LkFVProjectType] INT           NULL,
    [LkFVWorkFocus]   INT           NULL,
    [Enrolled]        BIT           NULL,
    [Referred]        BIT           NULL,
    [Refname]         NVARCHAR (30) NULL,
    [LKFVYear]        INT           NULL,
    [LkFVSPOrg]       INT           NULL,
    [CompDate]        DATE          NULL,
    [Yr2]             BIT           NULL,
    [Yr5]             BIT           NULL,
    [Followup]        BIT           NULL,
    [TAProjDate]      DATE          NULL,
    [ContactID]       INT           NULL,
    [RowIsActive]     BIT           CONSTRAINT [DF_FarmProjectData_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME      CONSTRAINT [DF_FarmProjectData_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FarmProjectData] PRIMARY KEY CLUSTERED ([ProjectID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TA Project Follow up Advisor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'ContactID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TA Project Follow up date completed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'TAProjDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TA Project Follow up - later yrs?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Followup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TA Project Follow up Yr 5?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Yr5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'TA Project Follow up Yr 2?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Yr2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date project completed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'CompDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Service provider organization', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'LkFVSPOrg';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project year assigned', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'LKFVYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Referral name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Refname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Referred?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Referred';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Enrolled?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'Enrolled';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Focus of planning work', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'LkFVWorkFocus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'LkFVProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm Project data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEnterprise_not used';

