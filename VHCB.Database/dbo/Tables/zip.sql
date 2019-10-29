CREATE TABLE [dbo].[zip] (
    [zip]                NVARCHAR (10) NOT NULL,
    [city]               NVARCHAR (50) NOT NULL,
    [other_towns]        NVARCHAR (75) NULL,
    [unacceptable_towns] NVARCHAR (50) NULL,
    [state]              NVARCHAR (2)  NULL,
    [County]             NVARCHAR (50) NULL,
    [latitude]           FLOAT (53)    NULL,
    [longitude]          FLOAT (53)    NULL,
    [DateModified]       DATETIME      CONSTRAINT [DF_zip_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_zip] PRIMARY KEY CLUSTERED ([zip] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longitude', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'longitude';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Latitude', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'latitude';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'County';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'state';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unacceptable towns', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'unacceptable_towns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Other acceptable towns', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'other_towns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'City', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'city';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zip code-5 digit-Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip', @level2type = N'COLUMN', @level2name = N'zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zip Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'zip';

