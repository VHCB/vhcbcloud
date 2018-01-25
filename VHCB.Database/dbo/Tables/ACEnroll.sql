CREATE TABLE [dbo].[ACEnroll] (
    [ACEnrollID]                      INT            IDENTITY (1, 1) NOT NULL,
    [Project #]                       NVARCHAR (255) NULL,
    [Last Name]                       NVARCHAR (255) NULL,
    [MI]                              NVARCHAR (255) NULL,
    [First Name]                      NVARCHAR (255) NULL,
    [DOB]                             DATETIME       NULL,
    [Email]                           NVARCHAR (255) NULL,
    [Address Type:]                   NVARCHAR (255) NULL,
    [Street #:]                       FLOAT (53)     NULL,
    [Address1:]                       NVARCHAR (255) NULL,
    [Address2:]                       NVARCHAR (255) NULL,
    [City:]                           NVARCHAR (255) NULL,
    [State:]                          NVARCHAR (255) NULL,
    [Zip code:]                       NVARCHAR (255) NULL,
    [Phone Type]                      NVARCHAR (255) NULL,
    [Phone #:]                        NVARCHAR (255) NULL,
    [1# Meal Preference:]             NVARCHAR (255) NULL,
    [Any other dietary restrictions?] NVARCHAR (255) NULL,
    [2# Tee Shirt Size:]              NVARCHAR (255) NULL,
    [Sweat Shirt Size:]               NVARCHAR (255) NULL,
    CONSTRAINT [PK_ACEnroll] PRIMARY KEY CLUSTERED ([ACEnrollID] ASC)
);

