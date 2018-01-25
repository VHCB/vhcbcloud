CREATE TABLE [dbo].[ProjectCheckReqQuestions] (
    [ProjectCheckReqQuestionID] INT      IDENTITY (1, 1) NOT NULL,
    [ProjectCheckReqID]         INT      NOT NULL,
    [LkPCRQuestionsID]          INT      NOT NULL,
    [Approved]                  BIT      CONSTRAINT [DF_ProjectCheckReqQuestions_Approved] DEFAULT ((0)) NOT NULL,
    [Date]                      DATE     NULL,
    [StaffID]                   INT      NULL,
    [RowIsActive]               BIT      CONSTRAINT [DF_ProjectCheckReqQuestions_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]              DATETIME CONSTRAINT [DF_ProjectCheckReqQuestions_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProjectCheckReqQuestions] PRIMARY KEY CLUSTERED ([ProjectCheckReqQuestionID] ASC),
    CONSTRAINT [FK_ProjectCheckReqQuestions_LkPCRQuestions] FOREIGN KEY ([LkPCRQuestionsID]) REFERENCES [dbo].[LkPCRQuestions] ([TypeID])
);


GO



CREATE TRIGGER [dbo].[trgIUDProjectCheckReqQuestions] ON [dbo].[ProjectCheckReqQuestions] 
after UPDATE, INSERT, DELETE
AS
	declare @ProjectCheckReqID int;
	DECLARE @TotalQues int
	DECLARE @TotalApprovedQues int
	declare @AllApproved bit

	--UPDATE
	if exists(SELECT * from inserted) and exists (SELECT * from deleted)
	begin
	select @ProjectCheckReqID = i.ProjectCheckReqID from inserted i;
	end

	--INSERT
	If exists (Select * from inserted) and not exists(Select * from deleted)
	begin
	select @ProjectCheckReqID = i.ProjectCheckReqID from inserted i;
	end

	--DELETE
	If exists(select * from deleted) and not exists(Select * from inserted)
	begin 
	SELECT @ProjectCheckReqID = i.ProjectCheckReqID from deleted i;
	end

	select @TotalQues = count(*) from ProjectCheckReqQuestions(nolock) where ProjectCheckReqID = @ProjectCheckReqID and RowIsActive = 1
 
	select @TotalApprovedQues = count(*) from ProjectCheckReqQuestions(nolock) where ProjectCheckReqID = @ProjectCheckReqID and RowIsActive = 1 and Approved = 1

	if(@TotalQues = @TotalApprovedQues)
		set @AllApproved = 1
	else
		set @AllApproved = 0

	update ProjectCheckReq set AllApproved = @AllApproved where ProjectCheckReqID = @ProjectCheckReqID
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'DateModified';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is row active', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'RowIsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Staff Approval responsibility', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'StaffID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date approved', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Approved y/n', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'Approved';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID of question', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'LkPCRQuestionsID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID of Check Request', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Record ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectCheckReqQuestions', @level2type = N'COLUMN', @level2name = N'ProjectCheckReqQuestionID';

