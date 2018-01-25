CREATE TABLE [dbo].[ProjectLeadBldg] (
    [LeadBldgID]   INT           IDENTITY (1, 1) NOT NULL,
    [ProjectID]    INT           NOT NULL,
    [Building]     INT           NOT NULL,
    [AddressID]    INT           NOT NULL,
    [Age]          INT           NULL,
    [Type]         INT           NULL,
    [LHCUnits]     INT           NULL,
    [FloodHazard]  BIT           NULL,
    [FloodIns]     BIT           NULL,
    [VerifiedBy]   INT           NULL,
    [InsuredBy]    VARCHAR (150) NULL,
    [HistStatus]   INT           NULL,
    [AppendA]      INT           NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_ProjectLeadBldg_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_ProjectLeadBldg_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLeadBldg] PRIMARY KEY CLUSTERED ([LeadBldgID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appendix A Determination', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'AppendA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Historic Status index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'HistStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insured by - EntityID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'InsuredBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'UserID index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'VerifiedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flood Insurance', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'FloodIns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flood Hazard Area', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'FloodHazard';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Enrolled LHC Units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'LHCUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Age of Bldg', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'Age';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'AddressID index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'AddressID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building ID index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'Building';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Lead index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadBldg', @level2type = N'COLUMN', @level2name = N'ProjectID';

