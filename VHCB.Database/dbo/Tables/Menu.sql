CREATE TABLE [dbo].[Menu] (
    [MenuID]           INT            IDENTITY (1, 1) NOT NULL,
    [MenuText]         NVARCHAR (200) NOT NULL,
    [MenuDescription]  NVARCHAR (300) NOT NULL,
    [Handler]          NVARCHAR (300) NULL,
    [IsDropDownToggle] BIT            NOT NULL,
    [ParentID]         INT            NOT NULL,
    [RowIsActive]      BIT            CONSTRAINT [DF_Menu_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]     DATETIME       CONSTRAINT [DF_Menu_DateModified] DEFAULT (getdate()) NOT NULL
);

