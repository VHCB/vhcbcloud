CREATE TABLE [dbo].[ApplicantApplicant] (
    [ApplicantApplicantId] INT      IDENTITY (1, 1) NOT NULL,
    [ApplicantId]          INT      NOT NULL,
    [AttachedApplicantId]  INT      NOT NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_ApplicantApplicant_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_ApplicantApplicant_DateModified] DEFAULT (getdate()) NOT NULL
);

