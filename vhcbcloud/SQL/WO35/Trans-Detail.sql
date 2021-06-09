begin tran

DECLARE @ProjectId as int, @Transdate as datetime, @TransAmt money, @Fund int, @LkTransType int

declare NewCursor Cursor for
select Project_id, [Transaction Date], Committed, Fund, [Grant or Loan]
from dbo.LeadFinancial lf(nolock)
join project_v v(nolock) on v.proj_num = lf.[Project #]
where [Project #] in ( '1966-000-049', '1966-000-070', '1966-000-116', '1967-100-045', '1967-200-028')

	open NewCursor
	fetch next from NewCursor into @ProjectId, @Transdate, @TransAmt, @Fund, @LkTransType
	WHILE @@FETCH_STATUS = 0
	begin

	declare @TransId int
	insert into trans(ProjectID, Date, TransAmt, LkTransaction, LkStatus, Balanced)
	select @ProjectId, @Transdate, @TransAmt, 238, 262, 1

	set @TransId =  SCOPE_IDENTITY()

	insert into detail(TransId, FundId, LkTransType, ProjectID, Amount)
	select @TransId, @Fund, @LkTransType, @ProjectId, @TransAmt

	FETCH NEXT FROM NewCursor INTO @ProjectId, @Transdate, @TransAmt, @Fund, @LkTransType
	END

Close NewCursor
deallocate NewCursor
go
commit


begin tran

DECLARE @ProjectId as int, @Transdate as datetime, @TransAmt money, @Fund int, @LkTransType int

declare NewCursor Cursor for
select Project_id, [Transaction Date], Committed, Fund, [Grant or Loan]
from dbo.LeadFinancial lf(nolock)
join project_v v(nolock) on v.proj_num = lf.[Project #]
where [Project #] in ( '1966-000-049', '1966-000-070', '1966-000-116', '1967-100-045', '1967-200-028')

	open NewCursor
	fetch next from NewCursor into @ProjectId, @Transdate, @TransAmt, @Fund, @LkTransType
	WHILE @@FETCH_STATUS = 0
	begin

	declare @TransId int
	insert into trans(ProjectID, Date, TransAmt, LkTransaction, LkStatus, Balanced)
	select @ProjectId, @Transdate, @TransAmt, 236, 262, 1

	set @TransId =  SCOPE_IDENTITY()

	insert into detail(TransId, FundId, LkTransType, ProjectID, Amount)
	select @TransId, @Fund, @LkTransType, @ProjectId, @TransAmt

	FETCH NEXT FROM NewCursor INTO @ProjectId, @Transdate, @TransAmt, @Fund, @LkTransType
	END

Close NewCursor
deallocate NewCursor
go
commit



select * from trans where LkTransaction = 236 and datemodified > getdate() - 1
select * from detail where datemodified > getdate() - 1

select * from trans where transid = 33415
select * from detail where transid = 33415