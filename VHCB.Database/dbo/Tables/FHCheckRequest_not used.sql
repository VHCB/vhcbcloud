CREATE TABLE [dbo].[FHCheckRequest_not used] (
    [FHCheckReqID]  INT           IDENTITY (1, 1) NOT NULL,
    [ProjectNumb]   NVARCHAR (12) NOT NULL,
    [Applicantname] NVARCHAR (60) NOT NULL,
    [VoucherDate]   DATETIME      NOT NULL,
    [RowIsActive]   BIT           CONSTRAINT [DF_FHCheckRequest_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME      CONSTRAINT [DF_FHCheckRequest_DateModified] DEFAULT (getdate()) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User entry', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHCheckRequest_not used', @level2type = N'COLUMN', @level2name = N'VoucherDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup from ApplcantName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHCheckRequest_not used', @level2type = N'COLUMN', @level2name = N'Applicantname';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Project Number "9999-999-999" Format - lookup to Project table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHCheckRequest_not used', @level2type = N'COLUMN', @level2name = N'ProjectNumb';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'FH Check Request Table ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FHCheckRequest_not used', @level2type = N'COLUMN', @level2name = N'FHCheckReqID';

