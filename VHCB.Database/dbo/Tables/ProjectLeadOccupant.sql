CREATE TABLE [dbo].[ProjectLeadOccupant] (
    [LeadOccupantID] INT           IDENTITY (1, 1) NOT NULL,
    [ProjectID]      INT           NOT NULL,
    [LeadBldgID]     INT           NOT NULL,
    [LeadUnitID]     INT           NOT NULL,
    [Name]           NVARCHAR (30) NULL,
    [LKAge]          INT           NULL,
    [LKEthnicity]    INT           NULL,
    [LKRace]         INT           NULL,
    [RowIsActive]    BIT           CONSTRAINT [DF_ProjectLeadOccupant_RowIsActive_1] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME      CONSTRAINT [DF_ProjectLeadOccupant_DateModified_1] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLeadOccupant] PRIMARY KEY CLUSTERED ([LeadOccupantID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Race', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'LKRace';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ethnicity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'LKEthnicity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Age', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'LKAge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LeadUnitID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'LeadUnitID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Building index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLeadOccupant', @level2type = N'COLUMN', @level2name = N'LeadBldgID';

