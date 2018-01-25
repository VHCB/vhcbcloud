CREATE TABLE [dbo].[ACMemberPerfData] (
    [MemberIncludedID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]           INT            NOT NULL,
    [ACYrQtrID]        INT            NOT NULL,
    [MemberIncluded]   NVARCHAR (350) NULL,
    [RowIsActive]      BIT            CONSTRAINT [DF_ACMemberPerfData_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME       CONSTRAINT [DF_ACMemberPerfData_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACMemberPerfData] PRIMARY KEY CLUSTERED ([MemberIncludedID] ASC)
);

