CREATE TABLE [dbo].[ACMemberForm] (
    [ACmemberformID] INT            IDENTITY (1, 1) NOT NULL,
    [ACMemberID]     INT            NOT NULL,
    [ACFormID]       INT            NOT NULL,
    [Received]       BIT            NULL,
    [Date]           DATE           NULL,
    [URL]            NVARCHAR (50)  NULL,
    [Notes]          NVARCHAR (350) NULL,
    [RowIsActive]    BIT            CONSTRAINT [DF_ACMemberForm_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]   DATETIME       CONSTRAINT [DF_ACMemberForm_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACMemberForm] PRIMARY KEY CLUSTERED ([ACmemberformID] ASC)
);

