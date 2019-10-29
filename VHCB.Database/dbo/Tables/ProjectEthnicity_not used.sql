CREATE TABLE [dbo].[ProjectEthnicity_not used] (
    [ProjectEthnicityID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]          INT        NOT NULL,
    [EthnicityID]        INT        NOT NULL,
    [LkProgram]          INT        NOT NULL,
    [Householdpeople]    INT        NULL,
    [RowIsActive]        BIT        CONSTRAINT [DF_ProjectEthnicity_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME   CONSTRAINT [DF_ProjectHHEthnicity_datemodified] DEFAULT (getdate()) NOT NULL,
    [RowVersion]         ROWVERSION NOT NULL,
    CONSTRAINT [PK_ProjectEthnicity] PRIMARY KEY CLUSTERED ([ProjectEthnicityID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of People within Ethnicity in Household', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'Householdpeople';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkProgram-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'LkProgram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ethnicity ID-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'EthnicityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used', @level2type = N'COLUMN', @level2name = N'ProjectEthnicityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ethnicity within Projects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEthnicity_not used';

