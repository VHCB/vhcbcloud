CREATE TABLE [dbo].[EnterpriseEvalMSSkillinfo] (
    [EnterEvalSkillTypeID] INT      IDENTITY (1, 1) NOT NULL,
    [EnterPriseEvalID]     INT      NOT NULL,
    [SkillType]            INT      NOT NULL,
    [PreLevel]             INT      NULL,
    [PostLevel]            INT      NULL,
    [RowIsActive]          BIT      CONSTRAINT [DF_EnterpriseEval MSSkillinfo_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]         DATETIME CONSTRAINT [DF_EnterpriseEval MSSkillinfo_DateModified] DEFAULT (getdate()) NOT NULL
);

