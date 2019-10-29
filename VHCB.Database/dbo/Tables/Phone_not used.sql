CREATE TABLE [dbo].[Phone_not used] (
    [PhoneId]        INT           IDENTITY (1, 1) NOT NULL,
    [AreaCode]       NVARCHAR (3)  NOT NULL,
    [PhoneNumber]    NVARCHAR (25) NOT NULL,
    [PhoneExtension] NVARCHAR (10) NULL,
    [RowIsActive]    BIT           NULL,
    [DateModified]   DATETIME      NOT NULL,
    CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([PhoneId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'PhoneExtension';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'PhoneNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Area code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'AreaCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone ID - primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used', @level2type = N'COLUMN', @level2name = N'PhoneId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone master table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Phone_not used';

