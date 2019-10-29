CREATE TABLE [dbo].[ACMembers] (
    [ACMemberID]    INT            IDENTITY (1, 1) NOT NULL,
    [ApplicantID]   INT            NOT NULL,
    [ContactID]     INT            NOT NULL,
    [StartDate]     DATE           NULL,
    [EndDate]       DATE           NULL,
    [HrServed]      INT            NULL,
    [LkSlot]        INT            NULL,
    [LkServiceType] INT            NULL,
    [LkExitType]    INT            NULL,
    [Tshirt]        INT            NULL,
    [SweatShirt]    INT            NULL,
    [DietPref]      INT            NULL,
    [MedConcerns]   NVARCHAR (350) NULL,
    [Notes]         NVARCHAR (MAX) NULL,
    [RowIsActive]   BIT            CONSTRAINT [DF_ACVolunteers_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME       CONSTRAINT [DF_ACMembers_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ACMembers] PRIMARY KEY CLUSTERED ([ACMemberID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkExitType record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'LkExitType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkServiceType record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'LkServiceType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LkSlot Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'LkSlot';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Hours Served', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'HrServed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'End Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Start Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Volunteer Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'ContactID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'AC Organization Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'ApplicantID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID-primary index', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers', @level2type = N'COLUMN', @level2name = N'ACMemberID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Americorps Members', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ACMembers';

