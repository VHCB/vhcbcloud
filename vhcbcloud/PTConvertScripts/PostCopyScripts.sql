USE PTConvert
GO
TRUNCATE TABLE  Applicant
TRUNCATE TABLE  ApplicantAppName
truncate table [dbo].[ProjectName]
truncate table [dbo].[AppName]
truncate table [dbo].[Contact]
truncate table [dbo].[Project]
truncate table [dbo].[ProjectApplicant]
--truncate table [dbo].[ProjectContact]
truncate table ApplicantContact


delete from  Applicant
delete from  ApplicantAppName
delete from [dbo].[ProjectName]
delete from [dbo].[AppName]
delete from [dbo].[Contact]
delete from [dbo].[Project]
delete from [dbo].[ProjectApplicant]
--delete from [dbo].[ProjectContact]
delete from ApplicantContact
delete from [LookupValues] where [LookupType] = 118 

--select * from project
--select * from AppName
--select * from Contact
--select * from ptprojectvhcb$ 
--select * from [dbo].[LookupValues]
--select * from ptorgs$
--select * from leadorgs$
--select * from [dbo].[LookupValues]
--select * from [dbo].[leadorgsvhcb$] where Contact =1
--select * from [LookupValues] where [LookupType] = 118
--select * from [ProjectApplicant]
--select * from [ProjectContact]
--select * from [ProjectName]
--select * from Applicant
--select * from ApplicantAppName
--select * from AppName

----------------------------------------------------------------------------------------------------

insert into Project (Proj_num )
select number  from ptprojectvhcb$ where number is not null

insert into Project (Proj_num )
select distinct tl.[pnumber] from [dbo].[translead$] tl join [dbo].[leadprojectsvhcb$]
 lp on tl.[proj_key] = lp.[key] where pnumber is not null
 
create table #temp (name varchar(max), number varchar (12))
insert into #temp (name, number)

 select distinct lp.name as name, tl.pnumber as number from [dbo].[translead$] tl join [dbo].[leadprojectsvhcb$]
 lp on tl.[proj_key] = lp.[key] where lp.name is not null
 
 insert into #temp (name, number)
 select distinct name as name,number as number from ptprojectvhcb$ where name is not null

insert into [LookupValues] ([LookupType],[Description], pnumber)
select 118, name, number from #temp
--select * from [LookupValues]

insert into AppName(Applicantname, ApplicantAbbrv, appkey)
select org, abbrv, [key] from [dbo].[leadorgsvhcb$] 

insert into AppName(Applicantname, ApplicantAbbrv, appkey)
select [name], abbrv,[key] from [dbo].[ptorgsvhcb$]

insert into ApplicantAppName(ApplicantID, AppNameID)
select [AppNameID], [AppNameID] from [dbo].[AppName]

insert into [dbo].[Applicant](ApplicantId)
select ApplicantID from ApplicantAppName

insert into [dbo].[Contact]([Firstname],[Lastname], KeyId)
select dbo.fnFirstName(org), dbo.fnLastName(org), [key] from [dbo].[leadorgsvhcb$] where Contact =1

insert into [dbo].[Contact]([Firstname],[Lastname], KeyId)
select dbo.fnFirstName([name]), dbo.fnLastName(name), [key] from [dbo].[ptorgsvhcb$] where Contact = 1

insert into [dbo].[ProjectName] ([LkProjectname],[ProjectID])
 select distinct lv.TypeID, p.ProjectId  from
 [dbo].[LookupValues] lv 
 join
 Project p on p.[Proj_num] = lv.pnumber
 where lv.LookupType = 118
 
 
create table #tempProj (number varchar(50), keyid varchar(10))
--insert into #tempProj(number, keyid)
--select number,app1key as [key]  from ptprojectvhcb$ where number is not null 

--insert into #tempProj(number, keyid)
--select distinct tl.[pnumber] as number, tl.[key] from [dbo].[translead$] tl join [dbo].[leadprojectsvhcb$]
-- lp on tl.[proj_key]  COLLATE SQL_Latin1_General_CP1_CI_AS = lp.[key] where pnumber is not null


-- insert into [dbo].[ProjectApplicant] ([ProjectId],[ApplicantId], [LkApplicantRole])
-- select distinct p.ProjectId, an.AppNameID, 358 from #tempProj tp join AppName an on tp.keyid = an.appkey COLLATE SQL_Latin1_General_CP1_CI_AS
-- join Project p on p.Proj_num = tp.number COLLATE SQL_Latin1_General_CP1_CI_AS
-- order by an.AppNameID

--insert into [dbo].[ProjectApplicant] (ApplicantId, ProjectId, LkApplicantRole)
--select ApplicantID, ProjectId, 358 from [VW_LeadProjectorgconnection] where ApplicantID is not null

--insert into [dbo].[ProjectApplicant] (ApplicantId, ProjectId, LkApplicantRole)
--select ApplicantID, ProjectId, 358 from [VW_PTProjectorgconnection] where ApplicantID is not null

--insert into [dbo].[ProjectApplicant] (ApplicantId, ProjectId, LkApplicantRole)
--select ApplicantID, ProjectId, 6359 from [VW_PTProjectorg2connection] where ApplicantID is not null and ProjectId is not null

insert into [dbo].[ProjectApplicant] (ApplicantId, ProjectId, LkApplicantRole)
select ApplicantID, ProjectId, lkapprole  from VW_ImportProjectApplicants where ProjectId is not null


insert into ApplicantContact (ContactID,ApplicantID)
select ContactId, ApplicantID from [dbo].[Manoj Lead Contacts]
union all
select ContactId, ApplicantID from [dbo].[Manoj PT Contacts]

--select  aan.ApplicantID, c.ContactId from  ApplicantAppName aan join AppName an on an.AppNameID = aan.AppNameID
--join Contact c on c.KeyId = an.appkey
--join ProjectApplicant pa on pa.ApplicantId = aan.ApplicantID

--insert into ProjectContact (ProjectID, ContactID)
--select ProjectId, ContactId from [dbo].[Manoj Lead Contacts] where ProjectId is not null
--union all
--select ProjectId, ContactId from [dbo].[Manoj PT Contacts] where ProjectId is not null

--select  pa.ProjectId, c.ContactId from  ApplicantAppName aan join AppName an on an.AppNameID = aan.AppNameID
--join Contact c on c.KeyId = an.appkey
--join ProjectApplicant pa on pa.ApplicantId = aan.ApplicantID


 drop table #tempProj
 drop table #temp

 select * from ProjectContact
