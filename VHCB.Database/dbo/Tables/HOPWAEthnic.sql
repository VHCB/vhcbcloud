CREATE TABLE [dbo].[HOPWAEthnic] (
    [HOPWAEthnicID] INT      IDENTITY (1, 1) NOT NULL,
    [HOPWAID]       INT      NOT NULL,
    [Ethnic]        INT      NULL,
    [EthnicNum]     INT      NULL,
    [RowIsActive]   BIT      CONSTRAINT [DF_HOPWAEthnic_RowIsActive] DEFAULT ((1)) NOT NULL,
    [DateModified]  DATETIME CONSTRAINT [DF_HOPWAEthnic_DateModified] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_HOPWAEthnic] PRIMARY KEY CLUSTERED ([HOPWAEthnicID] ASC),
    CONSTRAINT [FK_HOPWAEthnic_HOPWAMaster] FOREIGN KEY ([HOPWAID]) REFERENCES [dbo].[HOPWAMaster] ([HOPWAID])
);

