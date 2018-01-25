CREATE TABLE [dbo].[HomeOwnership] (
    [HomeOwnershipID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectId]       INT      NOT NULL,
    [AddressID]       INT      NOT NULL,
    [MH]              BIT      NULL,
    [Condo]           BIT      NULL,
    [SFD]             BIT      NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_ProjSingfam_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_Singfam_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Singfam] PRIMARY KEY CLUSTERED ([HomeOwnershipID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Single family detached', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'SFD';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Condo', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'Condo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Manufactured/Mobile Home', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'MH';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-FK', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership', @level2type = N'COLUMN', @level2name = N'HomeOwnershipID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project/Single Family info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HomeOwnership';

