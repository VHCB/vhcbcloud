CREATE TABLE [dbo].[EnterpriseGrantAttributes] (
    [EnterImpAttributeID] INT      IDENTITY (1, 1) NOT NULL,
    [EnterImpGrantID]     INT      NOT NULL,
    [LKAttributeID]       INT      NULL,
    [Date]                DATE     NULL,
    [RowIsActive]         BIT      CONSTRAINT [DF_EnterpriseGrantAttributes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]        DATETIME CONSTRAINT [DF_EnterpriseGrantAttributes_DteModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseGrantAttributes] PRIMARY KEY CLUSTERED ([EnterImpAttributeID] ASC)
);

