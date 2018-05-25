use PTConvert
go

select * from [dbo].[ptfund]
select * from ptfundtype

Update ptfund set [Key] = replace([Key],'"', ''), Typekey = replace(Typekey,'"', ''), Name = replace(Name,'"', ''), Abbrv = replace(Abbrv,'"', ''), Account = replace(Account,'"', '')

--Fund Population
alter view ptfund_v as
select *
from ptfund ptf(nolock)
join ptfundtype ptft(nolock) on ptf.Typekey = ptft.[key]
join LkFundType lkft(nolock) on lkft.Description  = ptft.type
go

select * from ptfund_v
go

truncate table Fund
go

insert into Fund(name, abbrv, LkFundType, account, FundKey)
select Name, Abbrv, TypeId, Account, [Key]
from ptfund_v
go

select * from Fund
go
---------------------------------------------------------------------------------------------------------

--Trans Population

--drop table Trans
--go

--drop table Detail
--go


delete from Trans
go

truncate table Detail
go

select  * from pttrans
go

update pttrans set Action = replace(Action, '"', ''), Projkey = replace(Projkey, '"', ''), [Key] = replace([Key], '"', '')
go

ALTER TABLE dbo.Project ALTER COLUMN Proj_num nvarchar (255)  
            COLLATE Latin1_General_CS_AS NOT NULL;

ALTER TABLE dbo.pttrans ALTER COLUMN Projkey nvarchar (255)  
            COLLATE Latin1_General_CS_AS NOT NULL;

insert into Trans(ProjectID, Date, TransAmt, LkTransaction, LkStatus, TRANSKEY)
select p.ProjectId, CONVERT(Datetime, t.Date, 120) date, Total as TransAmt,
case t.Action
	when 'Decommitment' then 239
	when 'Commitment' then 238
	when 'Reallocation' then 240
	when 'Disbursement' then 236
	when 'Refund' then 237
	else 0
end as LKTransaction, 262 as LKStatus, t.[Key]
from pttrans t(nolock) --dbftest$ t(nolock)
join Project p(nolock) on t.Projkey = p.Proj_num  --26146
where t.Date is not null and len(t.Date) = 10
go



select * from Trans
go
------------------------------------------------------------------------------------------------------------------
select * from ptdetail
go

update ptdetail set Transkey = replace(Transkey, '"', ''), Fundkey = replace(Fundkey, '"', ''), Grln = replace(Grln, '"', '')
go

--Detail Population

insert into Detail(TransId, FundId, LkTransType, ProjectID, Amount)
select t.TransId, ff.FundId,
case Grln
	when 'Grant' then 241
	when 'Loan' then 242
	else 0
end as LKTransType,
t.ProjectID, d.Amount
from Trans t(nolock)
join ptdetail d(nolock) on d.Transkey = t.TRANSKEY
join Fund ff(nolock) on  ff.FundKey = d.Fundkey
where  Grln is not null
go

select * from Detail

select * from Trans where LkTransaction = 237
--236 is decommitment

update d set d.Amount = -d.Amount
--select * 
from Detail d(nolock)
join Trans tr(nolock) on d.TransId = tr.TransId
where tr.LkTransaction = 236

update Trans set TransAmt = abs(TransAmt) where LkTransaction = 237
go

update d set d.Amount = abs(d.Amount)
--select * 
from Detail d(nolock)
join Trans tr(nolock) on d.TransId = tr.TransId
where tr.LkTransaction = 237
go

update Trans set Balanced = dbo.CheckIsBalanceZero(TransId)
go
-------------------------------------------------------------------------------------------------------------------------

update Trans set Balanced = 1
go

select distinct ProjectID from Trans
--5873

--5898

--25 More Projects in Foxpo

select distinct ProjectKey from pttrans


select * from Fund
go

select * from Trans  order by 1

go

select * from Detail
go