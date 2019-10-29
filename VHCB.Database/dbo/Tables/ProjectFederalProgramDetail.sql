CREATE TABLE [dbo].[ProjectFederalProgramDetail] (
    [ProjectFederalProgramDetailID] INT          IDENTITY (1, 1) NOT NULL,
    [ProjectFederalId]              INT          NOT NULL,
    [Recert]                        INT          NULL,
    [LKAffrdPer]                    INT          NULL,
    [AffrdPeriod]                   INT          NULL,
    [AffrdStart]                    DATE         NULL,
    [AffrdEnd]                      DATE         NULL,
    [CHDO]                          BIT          NULL,
    [CHDORecert]                    INT          NULL,
    [IsUARegulation]                BIT          NULL,
    [freq]                          INT          NULL,
    [IDISNum]                       NVARCHAR (4) NULL,
    [Setup]                         DATE         NULL,
    [CompleteBy]                    INT          NULL,
    [FundedDate]                    DATE         NULL,
    [FundCompleteBy]                INT          NULL,
    [IDISClose]                     DATE         NULL,
    [IDISCompleteBy]                INT          NULL,
    [RowIsActive]                   BIT          CONSTRAINT [DF_ProjectFederalProgramDetail_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]                  DATETIME     CONSTRAINT [DF_ProjectFederalProgramDetail_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Subject to UA Regulation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectFederalProgramDetail', @level2type = N'COLUMN', @level2name = N'IsUARegulation';

