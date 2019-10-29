CREATE TABLE [dbo].[Address] (
    [AddressId]     INT           IDENTITY (1, 1) NOT NULL,
    [LkAddressType] INT           NULL,
    [Street#]       NVARCHAR (12) NULL,
    [Address1]      NVARCHAR (60) NULL,
    [Address2]      NVARCHAR (60) NULL,
    [Village]       NVARCHAR (35) NULL,
    [latitude]      FLOAT (53)    NULL,
    [longitude]     FLOAT (53)    NULL,
    [Town]          NVARCHAR (50) NULL,
    [State]         NCHAR (2)     NULL,
    [Zip]           NCHAR (10)    NULL,
    [County]        NVARCHAR (20) NULL,
    [Country]       NVARCHAR (25) NULL,
    [RowVersion]    ROWVERSION    NULL,
    [UserID]        INT           NULL,
    [RowIsActive]   BIT           CONSTRAINT [DF_Address_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME      CONSTRAINT [DF_Address_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([AddressId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longitude', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'longitude';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Latitude', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'latitude';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to Town for town, village, county, zip, and district#', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'Village';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Line 2 Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'Address2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Line 1 Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'Address1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'House/Street Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'Street#';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkAddressType - FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'LkAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Address ID primary  index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address', @level2type = N'COLUMN', @level2name = N'AddressId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Holds Address Info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address';

