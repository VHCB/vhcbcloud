CREATE TABLE [dbo].[EnterpriseMasterServiceProvider] (
    [EnterpriseMasterServiceProvID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]                     INT      NOT NULL,
    [Year]                          INT      NOT NULL,
    [RowIsActive]                   BIT      CONSTRAINT [DF_EnterpriseMasterServiceProvider_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]                  DATETIME CONSTRAINT [DF_EnterpriseMasterServiceProvider_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EnterpriseMasterServiceProvider] PRIMARY KEY CLUSTERED ([EnterpriseMasterServiceProvID] ASC)
);

