CREATE TABLE [dbo].[EnterprisePrimeProduct] (
    [EnterprisePrimeProductID] INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]                INT            NOT NULL,
    [OtherNames]               NVARCHAR (150) NULL,
    [PrimaryProduct]           INT            NOT NULL,
    [HearAbout]                INT            NULL,
    [YrManageBus]              TEXT           NULL,
    [RowIsActive]              BIT            CONSTRAINT [DF_EnterpriseType_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]             DATETIME       CONSTRAINT [DF_EnterpriseType_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseType] PRIMARY KEY CLUSTERED ([EnterprisePrimeProductID] ASC)
);

