CREATE TABLE [dbo].[Contact] (
    [ContactId]    INT           IDENTITY (1, 1) NOT NULL,
    [Firstname]    NVARCHAR (30) NULL,
    [Lastname]     NVARCHAR (50) NULL,
    [MI]           VARCHAR (1)   NULL,
    [DOB]          DATE          NULL,
    [LkPosition]   INT           NULL,
    [FinLegal]     BIT           CONSTRAINT [DF_Contact_FinLegal] DEFAULT ((0)) NOT NULL,
    [Title]        NVARCHAR (25) NULL,
    [Manager]      BIT           NULL,
    [RowVersion]   ROWVERSION    NOT NULL,
    [UserID]       INT           NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_Contact_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_Contact_DateModified] DEFAULT (getdate()) NOT NULL,
    [LkPrefix]     INT           NULL,
    [LkSuffix]     INT           NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Last Modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row Active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Manager - for HOME program', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'Manager';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact''s Title, if any', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'Title';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Financial/Legal checkbox for ability to receive check', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'FinLegal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkPosition-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'LkPosition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact Last Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'Lastname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact First Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'Firstname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact ID primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact', @level2type = N'COLUMN', @level2name = N'ContactId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contact info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Contact';

