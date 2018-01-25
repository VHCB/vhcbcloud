CREATE TABLE [dbo].[HHinfo_not used] (
    [ProjectId]          INT            NOT NULL,
    [RptDate]            DATE           NULL,
    [LkHHOwnership]      INT            NOT NULL,
    [LkHHHousingAge]     INT            NOT NULL,
    [sqft]               NUMERIC (5)    NULL,
    [Rooms]              INT            NULL,
    [AsthmaUnder6]       INT            NULL,
    [Asthma617]          INT            NULL,
    [Asthma18]           INT            NULL,
    [DisabledUnder6]     INT            NULL,
    [Disabled617]        INT            NULL,
    [Disabled18]         INT            NULL,
    [Elderly]            INT            NULL,
    [InterventionCost]   MONEY          NULL,
    [RelocationCost]     MONEY          NULL,
    [MatchFundsCost]     MONEY          NULL,
    [Eligibility5080]    BIT            NULL,
    [Eligibilitybelow50] NCHAR (10)     NULL,
    [Completed]          BIT            NULL,
    [docsonfile]         BIT            NULL,
    [storyprofile]       BIT            NULL,
    [expensessubmit]     BIT            NULL,
    [CoordProg]          NVARCHAR (MAX) NULL,
    [DateModified]       DATETIME       CONSTRAINT [DF_HHinfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HHinfo] PRIMARY KEY CLUSTERED ([ProjectId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Last Modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Coordination with existing programs-orgs. and progs. involved in project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'CoordProg';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if itemized expenses have been submitted', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'expensessubmit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if submitting success story or project profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'storyprofile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T is supportin docs and receipts on file', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'docsonfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if Unit owner signed off on satisfactory completion', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Completed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Income Eligibility below 50% AMI', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Eligibilitybelow50';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Income Eligibility 50.1-80% AMI', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Eligibility5080';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Matching funds for eligible activities', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'MatchFundsCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Relocation Cost', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'RelocationCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Intervention cost including direct labor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'InterventionCost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of elderly people', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Elderly';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disabled people 18 and over', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Disabled18';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disabled people 6-17', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Disabled617';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Disabled people under 6', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'DisabledUnder6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'People 18 and over with Asthma', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Asthma18';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'People 6-17 with Asthma', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Asthma617';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'People under 6 with Asthma', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'AsthmaUnder6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Rooms in House', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'Rooms';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Square Footage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'sqft';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkHHHousingAge table-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'LkHHHousingAge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'lookup to LkHHownership-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'LkHHOwnership';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Reporting Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'RptDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Healthy Homes Info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HHinfo_not used';

