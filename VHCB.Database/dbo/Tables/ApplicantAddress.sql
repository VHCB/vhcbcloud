CREATE TABLE [dbo].[ApplicantAddress] (
    [ApplicantAddressID] INT       IDENTITY (1, 1) NOT NULL,
    [AddressId]          INT       NOT NULL,
    [ApplicantId]        INT       NOT NULL,
    [DefAddress]         BIT       CONSTRAINT [DF_OrgAddress_DefAddress] DEFAULT ((1)) NOT NULL,
    [AddType]            NCHAR (1) NULL,
    [RowIsActive]        BIT       NOT NULL,
    [DateModified]       DATETIME  NOT NULL,
    CONSTRAINT [PK_ApplicantAddress] PRIMARY KEY CLUSTERED ([ApplicantAddressID] ASC),
    CONSTRAINT [FK_ApplicantAddress_Address] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([AddressId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'M-Mailing address; P-Physical address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'AddType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default Address?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'DefAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Applicant ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'ApplicantId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Address ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'AddressId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress', @level2type = N'COLUMN', @level2name = N'ApplicantAddressID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Connection of Applicant to Addresses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicantAddress';

