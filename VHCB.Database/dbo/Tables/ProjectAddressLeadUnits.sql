CREATE TABLE [dbo].[ProjectAddressLeadUnits] (
    [PAddLeadUnitId] INT          IDENTITY (1, 1) NOT NULL,
    [AddressId]      INT          NOT NULL,
    [ProjectID]      INT          NOT NULL,
    [UnitNum]        NVARCHAR (5) NULL,
    [bedrooms]       INT          NULL,
    [datecompleted]  DATE         NULL,
    [TotRooms]       INT          NULL,
    [Vacant]         BIT          NULL,
    [Daycare]        BIT          NULL,
    [Reloc]          BIT          NULL,
    [RowVersion]     ROWVERSION   NOT NULL,
    [UserID]         INT          NULL,
    [RowIsActive]    BIT          CONSTRAINT [DF_ProjectAddressLeadUnits_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME     CONSTRAINT [DF_ProjectAddressLeadUnits_datemodified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectAddressLeadUnits] PRIMARY KEY CLUSTERED ([PAddLeadUnitId] ASC),
    CONSTRAINT [FK_ProjectAddressLeadUnits_Address] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([AddressId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Relocated during abatement?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'Reloc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Daycare in unit?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'Daycare';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Vacant unit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'Vacant';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total Rooms', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'TotRooms';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date completed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'datecompleted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'# of bedrooms', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'bedrooms';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unit ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'UnitNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Address ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'AddressId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits', @level2type = N'COLUMN', @level2name = N'PAddLeadUnitId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link between projects and Address for Lead program', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectAddressLeadUnits';

