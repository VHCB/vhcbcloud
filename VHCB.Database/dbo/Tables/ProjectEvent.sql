CREATE TABLE [dbo].[ProjectEvent] (
    [ProjectEventID] INT             IDENTITY (1, 1) NOT NULL,
    [Prog]           INT             NULL,
    [ProjectID]      INT             NULL,
    [ApplicantID]    INT             NULL,
    [EventID]        INT             NOT NULL,
    [SubEventID]     INT             NULL,
    [ProgEventID]    INT             NULL,
    [ProgSubEventID] INT             NULL,
    [EntityMSID]     INT             NULL,
    [EntitySubMSID]  INT             NULL,
    [Date]           DATE            CONSTRAINT [DF_ProjectEvent_Date] DEFAULT (getdate()) NULL,
    [Note]           NVARCHAR (MAX)  NULL,
    [URL]            NVARCHAR (1500) NULL,
    [UserID]         INT             NULL,
    [RowIsActive]    BIT             CONSTRAINT [DF_ProjectEvent_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME        CONSTRAINT [DF_ProjectEvent_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectEvent] PRIMARY KEY CLUSTERED ([ProjectEventID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is Row Active?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of Note', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Entity SubMileStone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'EntitySubMSID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Entity MileStone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'EntityMSID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Program SubMilestone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'ProgSubEventID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Program Milestone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'ProgEventID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Admin SubMilestone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'SubEventID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Admin Milestone ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'EventID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LookupID=34', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'Prog';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Events primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectEvent', @level2type = N'COLUMN', @level2name = N'ProjectEventID';

