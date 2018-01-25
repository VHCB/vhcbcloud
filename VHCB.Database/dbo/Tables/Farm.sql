CREATE TABLE [dbo].[Farm] (
    [FarmID]             INT           NOT NULL,
    [ApplicantID]        INT           NULL,
    [FarmName]           NVARCHAR (50) NULL,
    [LkFVEnterpriseType] INT           NULL,
    [AcresInProduction]  INT           NULL,
    [AcresOwned]         INT           NULL,
    [AcresLeased]        INT           NULL,
    [AcresLeasedOut]     INT           NULL,
    [TotalAcres]         INT           NULL,
    [OutOFBiz]           BIT           NULL,
    [Notes]              VARCHAR (MAX) NULL,
    [AgEd]               NVARCHAR (25) NULL,
    [YearsManagingFarm]  INT           NULL,
    [DateCreated]        DATETIME      NULL,
    [RowIsActive]        BIT           NOT NULL,
    [DateModified]       DATETIME      NOT NULL,
    CONSTRAINT [PK_Farm_1] PRIMARY KEY CLUSTERED ([FarmID] ASC)
);

