CREATE TABLE [dbo].[LookupSubValues] (
    [SubTypeID]      INT            IDENTITY (1, 1) NOT NULL,
    [TypeID]         INT            NOT NULL,
    [SubDescription] NVARCHAR (100) NULL,
    [Ordered]        INT            NULL,
    [RowIsActive]    BIT            CONSTRAINT [DF_LookupSubValues_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME       CONSTRAINT [DF_LookupSubValues_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LookupSubValues] PRIMARY KEY CLUSTERED ([SubTypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupSubValues', @level2type = N'COLUMN', @level2name = N'SubTypeID';

