CREATE TABLE [dbo].[ContactAddress] (
    [ContactAddressID] INT      IDENTITY (1, 1) NOT NULL,
    [ContactId]        INT      NOT NULL,
    [AddressId]        INT      NOT NULL,
    [LkAddressType]    INT      NOT NULL,
    [DefAdd]           BIT      CONSTRAINT [DF_ContactAddress_DefAdd] DEFAULT ((0)) NOT NULL,
    [RowIsActive]      BIT      CONSTRAINT [DF_ContactAddress_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME CONSTRAINT [DF_ContactAddress_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ContactAddress] PRIMARY KEY CLUSTERED ([ContactAddressID] ASC),
    CONSTRAINT [FK_ContactAddress_Address] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([AddressId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default Address?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'DefAdd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Address Record Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'AddressId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact Record Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'ContactId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress', @level2type = N'COLUMN', @level2name = N'ContactAddressID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link Table for Contacts and Addresses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContactAddress';

