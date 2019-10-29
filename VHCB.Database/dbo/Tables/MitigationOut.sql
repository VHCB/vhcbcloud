CREATE TABLE [dbo].[MitigationOut] (
    [MitigationOutID] INT      IDENTITY (1, 1) NOT NULL,
    [MitigationID]    INT      NOT NULL,
    [ProjectID]       INT      NULL,
    [DateClosed]      DATE     NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_MitigationSpent_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_MitigationOut] PRIMARY KEY CLUSTERED ([MitigationOutID] ASC),
    CONSTRAINT [FK_MitigationOut_Mitigation] FOREIGN KEY ([MitigationID]) REFERENCES [dbo].[Mitigation] ([MitigationID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date closed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut', @level2type = N'COLUMN', @level2name = N'DateClosed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Farm Closed or to close', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut', @level2type = N'COLUMN', @level2name = N'ProjectID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mitigtaion Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut', @level2type = N'COLUMN', @level2name = N'MitigationID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut', @level2type = N'COLUMN', @level2name = N'MitigationOutID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mitigation Funds spent', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MitigationOut';

