CREATE TABLE [dbo].[ProjectSurfaceWaters] (
    [SurfaceWatersID] INT           IDENTITY (1, 1) NOT NULL,
    [ProjectID]       INT           NOT NULL,
    [LKWaterShed]     INT           NOT NULL,
    [SubWaterShed]    NVARCHAR (75) NULL,
    [LKWaterBody]     INT           NULL,
    [FrontageFeet]    INT           NULL,
    [OtherWater]      NVARCHAR (75) NULL,
    [Riparian]        INT           NULL,
    [RowIsActive]     BIT           CONSTRAINT [DF_ProjectSurfaceWaters_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME      CONSTRAINT [DF_ProjectSurfaceWaters_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of stream or pond, etc.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'OtherWater';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Feet of Frontage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'FrontageFeet';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LookUpTypeID=140 Frontage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'LKWaterBody';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SubWaterShed Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'SubWaterShed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LookUpType=143', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'LKWaterShed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Housing Project index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectSurfaceWaters', @level2type = N'COLUMN', @level2name = N'SurfaceWatersID';

