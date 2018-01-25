CREATE TABLE [dbo].[UserPageSecurity] (
    [PageSecurityId] INT  IDENTITY (1, 1) NOT NULL,
    [Userid]         INT  NOT NULL,
    [pageid]         INT  NOT NULL,
    [isactive]       BIT  CONSTRAINT [DF_UserPageSecurity_isactive] DEFAULT ((1)) NOT NULL,
    [datemodified]   DATE CONSTRAINT [DF_UserPageSecurity_datemodified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_UserPageSecurity] PRIMARY KEY CLUSTERED ([PageSecurityId] ASC)
);

