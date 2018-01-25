CREATE TABLE [dbo].[ProjectFederalDetail] (
    [ProjectHOMEDetailID] INT          IDENTITY (1, 1) NOT NULL,
    [ProjectFederalId]    INT          NOT NULL,
    [Copyowner]           BIT          NULL,
    [Recert]              INT          NULL,
    [LKAffrdPer]          INT          NULL,
    [AffrdStart]          DATE         NULL,
    [CHDO]                BIT          NULL,
    [CHDORecert]          INT          NULL,
    [freq]                INT          NULL,
    [LastInspect]         DATE         NULL,
    [NextInspect]         NCHAR (4)    NULL,
    [Staff]               INT          NULL,
    [InspectDate]         DATE         NULL,
    [InspectLetter]       DATE         NULL,
    [RespDate]            DATE         NULL,
    [Regulation]          BIT          CONSTRAINT [DF_ProjectFederalDetail_Regulation] DEFAULT ((0)) NOT NULL,
    [IDISNum]             NVARCHAR (4) NULL,
    [Setup]               DATE         NULL,
    [CompleteBy]          INT          NULL,
    [FundedDate]          DATE         NULL,
    [IDISClose]           DATE         NULL,
    [RowIsActive]         BIT          CONSTRAINT [DF_ProjectFederalDetail_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]        DATETIME     CONSTRAINT [DF_ProjectFederalDetail_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectFederalDetail] PRIMARY KEY CLUSTERED ([ProjectHOMEDetailID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'IDIS Closeout date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'IDISClose';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date Funded', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'FundedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Completed By - staff ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'CompleteBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setup Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'Setup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'IDIS activity number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'IDISNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Response Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'RespDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date inspection letter sent', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'InspectLetter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of Inspection', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'InspectDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Staff responsible', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'Staff';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Next inspection year', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'NextInspect';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of last inspection', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'LastInspect';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Frequency to inspect in years-must be <=3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'freq';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'CHDO Recertification Month - numeric 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'CHDORecert';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'CHDO', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'CHDO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Affordability Start Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'AffrdStart';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'lookup to LkAffrdPer for # of years for affordability period', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'LKAffrdPer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Recertification month - numeric 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'Recert';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Copy owner on reminder letter', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'Copyowner';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail', @level2type = N'COLUMN', @level2name = N'ProjectFederalId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HOME program info', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalDetail';

