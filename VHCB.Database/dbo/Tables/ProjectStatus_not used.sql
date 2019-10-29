CREATE TABLE [dbo].[ProjectStatus_not used] (
    [ProjectStatusID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectID]       INT      NOT NULL,
    [LKProjStatus]    INT      NULL,
    [StatusDate]      DATE     NULL,
    [RowIsActive]     BIT      CONSTRAINT [DF_ProjectStatus_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME CONSTRAINT [DF_ProjectStatus_DateModified] DEFAULT (getdate()) NOT NULL
);

