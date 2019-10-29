CREATE TABLE [dbo].[OrganGrantApp_not used] (
    [OrganGrantID]  INT        NOT NULL,
    [ApplicantID]   INT        NOT NULL,
    [LkYear]        INT        NOT NULL,
    [OpBudget]      MONEY      NULL,
    [OrganBudget]   MONEY      NULL,
    [RentalUnit]    INT        NULL,
    [HomeUnits]     INT        NULL,
    [MobileUnits]   INT        NULL,
    [TotalProjects] INT        NULL,
    [FTE]           FLOAT (53) NULL,
    [TotIncome]     MONEY      NULL,
    [TotExpense]    MONEY      NULL,
    [RowIsActive]   BIT        CONSTRAINT [DF_OrganGrantApp_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME   CONSTRAINT [DF_OrganGrantApp_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_OrganGrantApp] PRIMARY KEY CLUSTERED ([OrganGrantID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Annual Operations Budget Expenses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'TotExpense';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Annual Operations Budget Income', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'TotIncome';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Employee FTE', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'FTE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total # of projects/developments', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'TotalProjects';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mobile Home pads', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'MobileUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Home ownership units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'HomeUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Rental units', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'RentalUnit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Organizational Budget', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'OrganBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Operations Budget', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'OpBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fiscal year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'LkYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used', @level2type = N'COLUMN', @level2name = N'OrganGrantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application for Organizational Grant', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OrganGrantApp_not used';

