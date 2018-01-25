CREATE TABLE [dbo].[ConserveAffMech] (
    [ConserveAffmechID] INT      IDENTITY (1, 1) NOT NULL,
    [ConserveID]        INT      NOT NULL,
    [LkConsAffMech]     INT      NOT NULL,
    [RowIsActive]       BIT      CONSTRAINT [DF_ConserveAffMech_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]      DATETIME CONSTRAINT [DF_ConserveAffMech_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ConserveAffMech_1] PRIMARY KEY CLUSTERED ([ConserveAffmechID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup to LkConsAffMech', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech', @level2type = N'COLUMN', @level2name = N'LkConsAffMech';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conserve Record Id', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech', @level2type = N'COLUMN', @level2name = N'ConserveID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech', @level2type = N'COLUMN', @level2name = N'ConserveAffmechID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Conservation link to Affordable Mechanism', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConserveAffMech';

