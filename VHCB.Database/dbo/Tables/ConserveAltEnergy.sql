CREATE TABLE [dbo].[ConserveAltEnergy] (
    [ConsserveAltEnergyID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]           INT      NOT NULL,
    [LkAltEnergy]          INT      NOT NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_ConserveAltEnergy_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_ConserveAltEnergy_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveAltEnergy_1] PRIMARY KEY CLUSTERED ([ConsserveAltEnergyID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkAltEnergy lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy', @level2type = N'COLUMN', @level2name = N'LkAltEnergy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy', @level2type = N'COLUMN', @level2name = N'ConsserveAltEnergyID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation Alternative energy', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAltEnergy';

