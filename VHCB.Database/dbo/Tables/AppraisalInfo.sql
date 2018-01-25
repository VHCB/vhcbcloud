CREATE TABLE [dbo].[AppraisalInfo] (
    [AppraisalInfoID] INT             IDENTITY (1, 1) NOT NULL,
    [AppraisalID]     INT             NULL,
    [LkAppraiser]     INT             NULL,
    [AppOrdered]      DATE            NULL,
    [AppRecd]         DATE            NULL,
    [EffDate]         DATE            NULL,
    [AppCost]         MONEY           NULL,
    [Comment]         NVARCHAR (MAX)  NULL,
    [NRCSSent]        DATE            NULL,
    [RevApproved]     BIT             NULL,
    [ReviewDate]      DATE            NULL,
    [URL]             NVARCHAR (1500) NULL,
    [RowIsActive]     BIT             CONSTRAINT [DF_AppraisalInfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]    DATETIME        CONSTRAINT [DF_AppraisalInfo_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AppraisalInfo] PRIMARY KEY CLUSTERED ([AppraisalInfoID] ASC)
);

