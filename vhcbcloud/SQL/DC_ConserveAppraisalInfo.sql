use PTConvert
go

delete from VHCB.dbo.AppraisalInfo
go

insert into VHCB.dbo.AppraisalInfo(AppraisalID, LkAppraiser, AppOrdered, AppRecd, EffDate, AppCost, Comment)
select av.[AppraisalID], EntityID, pta.appordered, pta.[Appraisalrecd], pta.[EffectiveDate], REPLACE(REPLACE(pta.[TotalAppcost], '$', ''), ',', ''), pta.[Comments]
from [dbo].[ptappraisals] pta
join [dbo].[MasterProj] mp on mp.[Proj_num] = pta.Projnum
join VHCB.dbo.AppraisalValue av on av.ProjectID = mp.[ProjectId]

go

select * from VHCB.dbo.AppraisalInfo
go