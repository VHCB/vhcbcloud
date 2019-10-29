CREATE TABLE [dbo].[ProjectCheckReqNOD] (
    [ProjectCheckReqNOD] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectCheckReqID]  INT      NOT NULL,
    [LKNOD]              INT      NOT NULL,
    [RowIsActive]        BIT      CONSTRAINT [DF_ProjectCheckReqNOD_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]       DATETIME CONSTRAINT [DF_ProjectCheckReqNOD_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectCheckReqNOD] PRIMARY KEY CLUSTERED ([ProjectCheckReqNOD] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nature of Disbursement Type ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqNOD', @level2type = N'COLUMN', @level2name = N'LKNOD';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID of CheckRequest', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqNOD', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqNOD', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqNOD';

