CREATE TABLE [dbo].[AppraisalValue] (
    [AppraisalID]  INT            IDENTITY (1, 1) NOT NULL,
    [ProjectID]    INT            NOT NULL,
    [TotAcres]     INT            NULL,
    [Apbef]        MONEY          NULL,
    [Apaft]        MONEY          NULL,
    [Aplandopt]    MONEY          NULL,
    [Exclusion]    MONEY          NULL,
    [EaseValue]    MONEY          NULL,
    [FeeValue]     MONEY          NULL,
    [Valperacre]   MONEY          NULL,
    [Comments]     NVARCHAR (MAX) NULL,
    [RowIsActive]  BIT            CONSTRAINT [DF_Applctn_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_Applctn_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Appraisals] PRIMARY KEY CLUSTERED ([AppraisalID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalValue', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalValue', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalValue', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Appraisal Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalValue', @level2type = N'COLUMN', @level2name = N'AppraisalID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Info on Appraisals', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppraisalValue';

