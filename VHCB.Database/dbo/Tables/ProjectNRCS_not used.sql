CREATE TABLE [dbo].[ProjectNRCS_not used] (
    [NRCSID]            INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]         INT      NOT NULL,
    [HalfAppraisal]     MONEY    NULL,
    [VHCBEasementPrice] MONEY    NULL,
    [TotalPrice]        MONEY    NULL,
    [NRCSEaseAppraisal] MONEY    NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ProjectNRCS_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ProjectNRCS_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectNRCS] PRIMARY KEY CLUSTERED ([NRCSID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Last Modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'NRCS Appraised Value of Easement', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'NRCSEaseAppraisal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total purchase price', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'TotalPrice';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'VHCB Purchase price of easement', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'VHCBEasementPrice';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'!/2 of Appraisal', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'HalfAppraisal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectNRCS_not used', @level2type = N'COLUMN', @level2name = N'NRCSID';

