CREATE TABLE [dbo].[FederalProjectInspection] (
    [FederalProjectInspectionID] INT       IDENTITY (1, 1) NOT NULL,
    [ProjectFederalID]           INT       NOT NULL,
    [InspectDate]                DATE      NULL,
    [NextInspect]                NCHAR (4) NULL,
    [InspectStaff]               INT       NULL,
    [InspectLetter]              DATE      NULL,
    [RespDate]                   DATE      NULL,
    [Deficiency]                 BIT       CONSTRAINT [DF_FederalProjectInspection_Deficiency] DEFAULT ((0)) NOT NULL,
    [InspectDeadline]            DATE      NULL,
    [RowIsActive]                BIT       CONSTRAINT [DF_FederalProjectInspection_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]               DATETIME  CONSTRAINT [DF_FederalProjectInspection_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FederalProjectInspection] PRIMARY KEY CLUSTERED ([FederalProjectInspectionID] ASC)
);

