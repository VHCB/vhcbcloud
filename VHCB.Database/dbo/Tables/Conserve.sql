CREATE TABLE [dbo].[Conserve] (
    [ConserveID]   INT             IDENTITY (1, 1) NOT NULL,
    [ProjectID]    INT             NOT NULL,
    [SubmitDate]   DATE            NULL,
    [Fnlbdgt]      BIT             CONSTRAINT [DF_Conserve_Fnlbdgt] DEFAULT ((0)) NOT NULL,
    [LkConsTrack]  INT             NULL,
    [Apbef]        MONEY           NULL,
    [Apaft]        MONEY           NULL,
    [Enhanceval]   MONEY           NULL,
    [Aplandopt]    MONEY           NULL,
    [NRCSEaseval]  MONEY           NULL,
    [VHCBEaseval]  MONEY           NULL,
    [PrimStew]     BIGINT          NULL,
    [NumEase]      INT             NULL,
    [TotalAcres]   DECIMAL (18, 2) NULL,
    [Wooded]       DECIMAL (18, 2) NULL,
    [Prime]        DECIMAL (18, 2) NULL,
    [Statewide]    DECIMAL (18, 2) NULL,
    [Tillable]     DECIMAL (18, 2) NULL,
    [Pasture]      DECIMAL (18, 2) NULL,
    [Unmanaged]    DECIMAL (18, 2) NULL,
    [Naturalrec]   DECIMAL (18, 2) NULL,
    [FarmResident] DECIMAL (18, 2) NULL,
    [UserID]       INT             NULL,
    [RowVersion]   ROWVERSION      NOT NULL,
    [RowIsActive]  BIT             CONSTRAINT [DF_Conserve_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME        CONSTRAINT [DF_Conserve_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Conserve] PRIMARY KEY CLUSTERED ([ConserveID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last user''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'UserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Steward-Applicant ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'PrimStew';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB easement value (apbef - (apaft+enhanceval))-calculated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'VHCBEaseval';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'NRCS easement value (apbef-apaft) calculated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'NRCSEaseval';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraised value of land only with option-no bldgs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'Aplandopt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Enhancement Value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'Enhanceval';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraised Value after', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'Apaft';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraised value before', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'Apbef';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkConsTrack record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'LkConsTrack';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T if final budget-makes budget fields read-only', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'Fnlbdgt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date application was first submitted', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'SubmitDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Conserve';

