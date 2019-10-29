CREATE TABLE [dbo].[PTproject$] (
    [key]     NVARCHAR (255) NULL,
    [app1key] NVARCHAR (255) NULL,
    [number]  NVARCHAR (255) NULL,
    [name]    NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [app1key]
    ON [dbo].[PTproject$]([key] ASC);

