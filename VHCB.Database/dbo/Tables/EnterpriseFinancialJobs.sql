CREATE TABLE [dbo].[EnterpriseFinancialJobs] (
    [EnterFinancialJobsID] INT             IDENTITY (1, 1) NOT NULL,
    [ProjectID]            INT             NOT NULL,
    [StatusPt]             INT             NULL,
    [MSDate]               DATE            NULL,
    [Year]                 NCHAR (10)      NULL,
    [GrossSales]           MONEY           NULL,
    [Netincome]            MONEY           NULL,
    [GrossPayroll]         MONEY           NULL,
    [FamilyEmp]            DECIMAL (18, 2) CONSTRAINT [DF_EnterpriseFinancialJobs_FamilyEmp] DEFAULT ((0)) NOT NULL,
    [NonFamilyEmp]         DECIMAL (18, 2) CONSTRAINT [DF_EnterpriseFinancialJobs_NonFamilyEmp] DEFAULT ((0)) NOT NULL,
    [Networth]             MONEY           NULL,
    [RowIsActive]          BIT             CONSTRAINT [DF_EnterpriseFinancialJobs_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME        CONSTRAINT [DF_EnterpriseFinancialJobs_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseFinancialJobs] PRIMARY KEY CLUSTERED ([EnterFinancialJobsID] ASC)
);



