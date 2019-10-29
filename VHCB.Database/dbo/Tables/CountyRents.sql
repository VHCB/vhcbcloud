CREATE TABLE [dbo].[CountyRents] (
    [CountyRentId] INT      IDENTITY (1, 1) NOT NULL,
    [FedProgID]    INT      NOT NULL,
    [County]       INT      NOT NULL,
    [StartDate]    DATE     NOT NULL,
    [EndDate]      DATE     NOT NULL,
    [RowIsActive]  BIT      CONSTRAINT [DF_CountyRents_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME CONSTRAINT [DF_CountyRents_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CountyRents] PRIMARY KEY CLUSTERED ([CountyRentId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date record last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyRents', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyRents', @level2type = N'COLUMN', @level2name = N'County';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID Primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyRents', @level2type = N'COLUMN', @level2name = N'CountyRentId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'HOME program-maintenance of rent costs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CountyRents';

