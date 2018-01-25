CREATE TABLE [dbo].[ConservePlan] (
    [ConservePlanID] INT             IDENTITY (1, 1) NOT NULL,
    [ConserveID]     INT             NOT NULL,
    [LKManagePlan]   INT             NOT NULL,
    [DispDate]       DATE            NOT NULL,
    [Comments]       NVARCHAR (MAX)  NULL,
    [URL]            NVARCHAR (1500) NULL,
    [RowIsActive]    BIT             CONSTRAINT [DF_ConservePlan_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME        CONSTRAINT [DF_ConservePlan_DateModified] DEFAULT (getdate()) NOT NULL
);

