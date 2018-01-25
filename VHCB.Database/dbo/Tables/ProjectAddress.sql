CREATE TABLE [dbo].[ProjectAddress] (
    [ProjectaddressID] INT        IDENTITY (1, 1) NOT NULL,
    [ProjectId]        INT        NOT NULL,
    [AddressId]        INT        NOT NULL,
    [PrimaryAdd]       BIT        NULL,
    [RowVersion]       ROWVERSION NOT NULL,
    [UserID]           INT        NULL,
    [RowIsActive]      BIT        CONSTRAINT [DF_ProjectAddress_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME   CONSTRAINT [DF_ProjectAddress_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectAddress] PRIMARY KEY CLUSTERED ([ProjectaddressID] ASC),
    CONSTRAINT [FK_ProjectAddress_Address] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([AddressId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ProjectAddress]
    ON [dbo].[ProjectAddress]([ProjectId] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Address Y/N', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'PrimaryAdd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Address ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'AddressId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress', @level2type = N'COLUMN', @level2name = N'ProjectaddressID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link table from Project to Addresses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddress';

