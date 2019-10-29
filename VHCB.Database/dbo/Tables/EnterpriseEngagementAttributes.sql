CREATE TABLE [dbo].[EnterpriseEngagementAttributes] (
    [EnterEngageAttrID]  INT      IDENTITY (1, 1) NOT NULL,
    [EnterFundamentalID] INT      NOT NULL,
    [LKAttributeID]      INT      NOT NULL,
    [Date]               DATE     NULL,
    [RowIsActive]        BIT      CONSTRAINT [DF_EnterpriseEngagementAttributes_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME CONSTRAINT [DF_EnterpriseEngagementAttributes_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseEngagementAttributes] PRIMARY KEY CLUSTERED ([EnterEngageAttrID] ASC)
);

