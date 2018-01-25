CREATE TABLE [dbo].[EnterpriseEvalMilestones] (
    [EnterpriseEvalID]   INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]          INT            NULL,
    [Milestone]          INT            NULL,
    [MSDate]             DATE           NULL,
    [Comment]            NVARCHAR (MAX) NULL,
    [LeadPlanAdvisorExp] NVARCHAR (MAX) NULL,
    [PlanProcess]        BIT            NULL,
    [LoanReq]            MONEY          NULL,
    [LoanRec]            MONEY          NULL,
    [LoanPend]           BIT            NULL,
    [GrantReq]           MONEY          NULL,
    [GrantRec]           MONEY          NULL,
    [GrantPend]          BIT            NULL,
    [OtherReq]           MONEY          NULL,
    [OtherRec]           MONEY          NULL,
    [OtherPend]          BIT            NULL,
    [SharedOutcome]      NVARCHAR (MAX) NULL,
    [QuoteUse]           INT            NULL,
    [QuoteName]          NVARCHAR (25)  NULL,
    [RowIsActive]        BIT            CONSTRAINT [DF_EnterpriseEvalMilestones_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME       CONSTRAINT [DF_EnterpriseEvalMilestones_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Other $$ Pending', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'OtherPend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Other $$ received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'OtherRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Other $$ requested', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'OtherReq';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant $$ Pending', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'GrantPend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant $$ received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'GrantRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grant $$ requested', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'GrantReq';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Loan $$ pending', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'LoanPend';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Loan $$ received', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'LoanRec';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Loan $$ requested', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EnterpriseEvalMilestones', @level2type = N'COLUMN', @level2name = N'LoanReq';

