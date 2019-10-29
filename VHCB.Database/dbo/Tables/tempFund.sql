CREATE TABLE [dbo].[tempFund] (
    [projectid]        INT           NULL,
    [fundid]           INT           NULL,
    [lktranstype]      INT           NULL,
    [FundType]         NVARCHAR (10) NULL,
    [Projnum]          NVARCHAR (12) NULL,
    [ProjectName]      NVARCHAR (80) NULL,
    [AppID]            INT           NULL,
    [AppAbbrv]         NVARCHAR (25) NULL,
    [Date]             DATE          NULL,
    [PayeeApplicant]   INT           NULL,
    [FundAbbrv]        NVARCHAR (25) NULL,
    [commitmentamount] MONEY         NULL,
    [expendedamount]   MONEY         NULL
);

