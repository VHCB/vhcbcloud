CREATE TABLE [dbo].[LookupValues] (
    [TypeID]       INT            IDENTITY (1, 1) NOT NULL,
    [LookupType]   INT            NOT NULL,
    [Description]  NVARCHAR (100) NULL,
    [Ordering]     INT            CONSTRAINT [DF_LookupValues_Ordering] DEFAULT ((0)) NOT NULL,
    [SubReq]       BIT            NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_LookupValues_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_Table_1_DateeModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_LookupValues] PRIMARY KEY CLUSTERED ([TypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Sub Entry required', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupValues', @level2type = N'COLUMN', @level2name = N'SubReq';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LKTable and get recordID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LookupValues', @level2type = N'COLUMN', @level2name = N'LookupType';

