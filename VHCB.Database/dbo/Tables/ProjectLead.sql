CREATE TABLE [dbo].[ProjectLead] (
    [ProjectLeadID]  INT      IDENTITY (1, 1) NOT NULL,
    [ProjectId]      INT      NOT NULL,
    [StartDate]      DATE     NULL,
    [UnitsClearDate] DATE     NULL,
    [Grantamt]       MONEY    NULL,
    [HHIntervention] MONEY    NULL,
    [Loanamt]        MONEY    NULL,
    [Relocation]     MONEY    NULL,
    [ClearDecom]     MONEY    NULL,
    [Testconsult]    INT      NULL,
    [PBCont]         INT      NULL,
    [TotAward]       MONEY    NULL,
    [RowIsActive]    BIT      CONSTRAINT [DF_ProjectLead_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME CONSTRAINT [DF_ProjectLead_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectLead] PRIMARY KEY CLUSTERED ([ProjectLeadID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Award amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'TotAward';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lead Contractor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'PBCont';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Testing Consultant', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'Testconsult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Clearance D-commit amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'ClearDecom';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Loan amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'Loanamt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant Amt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'Grantamt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'All units cleared date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'UnitsClearDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Start Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead', @level2type = N'COLUMN', @level2name = N'ProjectLeadID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Lead link table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectLead';

