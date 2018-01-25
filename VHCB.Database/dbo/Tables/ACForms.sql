CREATE TABLE [dbo].[ACForms] (
    [ACFormID]     INT           IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50) NULL,
    [Ordernum]     INT           NULL,
    [Groupnum]     INT           NULL,
    [RowIsActive]  BIT           CONSTRAINT [DF_ACForms_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified] DATETIME      CONSTRAINT [DF_ACForms_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACForms] PRIMARY KEY CLUSTERED ([ACFormID] ASC)
);

